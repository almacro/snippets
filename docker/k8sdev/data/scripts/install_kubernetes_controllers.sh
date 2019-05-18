#!/usr/bin/env bash
#
# install kubernetes controllers

# for i in 0 1 2
# do
#   gcloud compute instances create controller-${i} \
#     --async \
#     --boot-disk-size 200GB \
#     --can-ip-forward \
#     --image-family ubuntu-1804-lts \
#     --image-project ubuntu-os-cloud \
#     --machine-type n1-standard-1 \
#     --private-network-ip 10.240.0.1${i} \
#     --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
#     --subnet "${GCP_SUBNET}" \
#     --tags "${GCP_NETWORK}.controller"
# done

for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller
done
