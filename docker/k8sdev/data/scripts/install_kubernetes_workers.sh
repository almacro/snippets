#!/usr/bin/env bash
#
# install kubernetes workers

# for i in 0 1 2
# do
#   gcloud compute instances create worker-${i} \
#     --async \
#     --boot-disk-size 200GB \
#     --can-ip-forward \
#     --image-family ubuntu-1804-lts \
#     --image-project ubuntu-os-cloud \
#     --machine-type n1-standard-1 \
#     --metadata pod-cidr=10.200.${i}.0/24 \
#     --private-network-ip 10.240.0.2${i} \
#     --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
#     --subnet "${GCP_SUBNET}" \
#     --tags "${GCP_NETWORK}.worker"
# done

for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,worker
done
