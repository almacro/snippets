#!/usr/bin/env bash
#
# configure nginx to vend HTTP health check instances

sudo apt-get install -y nginx

cat > kubernetes.default.svc.cluster.local <<EOF
server {
  listen      80;
  server_name kubernetes.default.svc.cluster.local;

  location /healthz {
    proxy_pass                    https://127.0.0.1:6443/healthz;
    proxy_ssl_trusted_certificate /var/lib/kubernetes/ca.pem;
  }
}
EOF

sudo mv kubernetes.default.svc.cluster.local \
  /etc/nginx/sites-available/kubernetes.default.svc.cluster.local

sudo ln -s /etc/nginx/sites-available/kubernetes.default.svc.cluster.local /etc/nginx/sites-enabled/

sudo systemctl restart nginx

sudo systemctl enable nginx

kubectl get componentstatuses --kubeconfig admin.kubeconfig

# run on each controller node: controller-0, controller-1, and controller-2
#
curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz

