#!/usr/bin/env bash
#
# distribute the Kubernetes configuration files

for instance in worker-0 worker-1 worker-2
do
  gcloud compute scp ${instance}.kubeconfig kube-proxy.kubeconfig ${instance}:~/
done

for instance in controller-0 controller-1 controller-2
do
  gcloud compute scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done
