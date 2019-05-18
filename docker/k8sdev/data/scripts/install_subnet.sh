#!/usr/bin/env bash
#
# install subnet into vpc

# gcloud compute networks subnets create "${GCP_SUBNET}" \
#   --network "${GCP_NETWORK}" \
#   --range 10.240.0.0/24

gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24
