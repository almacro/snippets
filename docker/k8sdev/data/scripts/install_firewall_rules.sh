#!/usr/bin/env bash
#
# install firewall rules

# gcloud compute firewall-rules create "${GCP_FW_INT}" \
#   --allow tcp,udp,icmp \
#   --network "${GCP_NETWORK}" \
#   --source-ranges 10.240.0.0/24,10.200.0.0/16

# gcloud compute firewall-rules create "${GCP_FW_EXT}" \
#   --allow tcp:22,tcp:6443,icmp \
#   --network "${GCP_NETWORK}" \
#   --source-ranges 0.0.0.0/0

gcloud compute firewall-rules create kubernetes-the-hard-way-internal \
  --allow tcp,udp,icmp \
  --network  kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

gcloud compute firewall-rules create kubernetes-the-hard-way-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

