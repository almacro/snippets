#!/usr/bin/env bash
#
# retrieve the Kubernetes cluster static ip address

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')
