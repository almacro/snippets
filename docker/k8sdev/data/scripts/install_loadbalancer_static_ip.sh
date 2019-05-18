#!/usr/bin/env bash
#
# install static IP for API loadbalancer

# gcloud compute addresses create "${GCP_NETWORK}" \
#   --region $(gcloud config get-value compute/region)

gcloud compute addresses create kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region)
