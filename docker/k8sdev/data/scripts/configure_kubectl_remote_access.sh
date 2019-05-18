#!/usr/bin/env bash
#
# configure remote access to kubectl

# NOTE  Run the commands in this lab from the same directory used to generate the admin client certificates.

#   Generate a kubeconfig file suitable for authenticating as the admin user:
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials admin \
  --client-certificate=admin.pem \
  --client-key=admin-key.pem

kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin

kubectl config use-context kubernetes-the-hard-way

# Verification
#   Check the health of the remote Kubernetes cluster:
kubectl get componentstatuses
