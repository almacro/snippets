#!/usr/bin/env bash
#
# run smoke tests to check cluster setup


# verify the ability to encrypt secret data at rest.

#   Create a generic secret:
kubectl create secret generic kubernetes-the-hard-way \
  --from-literal="mykey=mydata"

#   Print a hexdump of the kubernetes-the-hard-way secret stored in etcd:
gcloud compute ssh controller-0 \
  --command "sudo ETCDCTL_API=3 etcdctl get \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem \
  /registry/secrets/default/kubernetes-the-hard-way | hexdump -C"


# verify the ability to create and manage Deployments.

#   Create a deployment for the nginx web server:
kubectl run nginx --image=nginx

# kubectl run --generator=deployment/apps.v1beta1 is DEPRECATED and will be removed in a future version. Use kubectl create instead.
# deployment.apps/nginx created


#   List the pod created by the nginx deployment:
kubectl get pods -l run=nginx

# verify the ability to access applications remotely using port forwarding.

#   Retrieve the full name of the nginx pod:
POD_NAME=$(kubectl get pods -l run=nginx -o jsonpath="{.items[0].metadata.name}")

#   Forward port 8080 on your local machine to port 80 of the nginx pod:
kubectl port-forward $POD_NAME 8080:80

#   In a new terminal make an HTTP request using the forwarding address:
curl --head http://127.0.0.1:8080

#   Switch back to the previous terminal and stop the port forwarding to the nginx pod:
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
Handling connection for 8080
^C


# verify the ability to retrieve container logs.

#   Print the nginx pod logs:
kubectl logs $POD_NAME


# verify the ability to execute commands in a container.

#   Print the nginx version by executing the nginx -v command in the nginx container:
kubectl exec -ti $POD_NAME -- nginx -v


# verify the ability to expose applications using a Service.

#   Expose the nginx deployment using a NodePort service:
kubectl expose deployment nginx --port 80 --type NodePort

#   Retrieve the node port assigned to the nginx service:
NODE_PORT=$(kubectl get svc nginx \
  --output=jsonpath='{range .spec.ports[0]}{.nodePort}')

#   Create a firewall rule that allows remote access to the nginx node port:
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-nginx-service \
  --allow=tcp:${NODE_PORT} \
  --network kubernetes-the-hard-way

#   Retrieve the external IP address of a worker instance:
EXTERNAL_IP=$(gcloud compute instances describe worker-0 \
  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')

#   Make an HTTP request using the external IP address and the nginx node port:
curl -I http://${EXTERNAL_IP}:${NODE_PORT}


# verify the ability to run untrusted workloads using gVisor.

#   Create the untrusted pod:
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: untrusted
  annotations:
    io.kubernetes.cri.untrusted-workload: "true"
spec:
  containers:
    - name: webserver
      image: gcr.io/hightowerlabs/helloworld:2.0.0
EOF


# verify the untrusted pod is running under gVisor (runsc) by inspecting
#   the assigned worker node.

#   Verify the untrusted pod is running:
kubectl get pods -o wide

#   Get the node name where the untrusted pod is running:
INSTANCE_NAME=$(kubectl get pod untrusted --output=jsonpath='{.spec.nodeName}')

#   SSH into the worker node:
gcloud compute ssh ${INSTANCE_NAME}

#   List the containers running under gVisor:
sudo runsc --root  /run/containerd/runsc/k8s.io list

#   Get the ID of the untrusted pod:
POD_ID=$(sudo crictl -r unix:///var/run/containerd/containerd.sock \
  pods --name untrusted -q)

#   Get the ID of the webserver container running in the untrusted pod:
CONTAINER_ID=$(sudo crictl -r unix:///var/run/containerd/containerd.sock \
  ps -p ${POD_ID} -q)

#   Use the gVisor runsc command to display the processes running inside the webserver container:
sudo runsc --root /run/containerd/runsc/k8s.io ps ${CONTAINER_ID}
