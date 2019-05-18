#!/usr/bin/env bash
#
# provision network routes to allow pods to communicate across worker nodes

#   Print the internal IP address and Pod CIDR range for each worker instance:
for instance in worker-0 worker-1 worker-2
do
  gcloud compute instances describe ${instance} \
    --format 'value[separator=" "](networkInterfaces[0].networkIP,metadata.items[0].value)'
done

#   Create network routes for each worker instance:
for i in 0 1 2; do
  gcloud compute routes create kubernetes-route-10-200-${i}-0-24 \
    --network kubernetes-the-hard-way \
    --next-hop-address 10.240.0.2${i} \
    --destination-range 10.200.${i}.0/24
done

#   List the routes in the kubernetes-the-hard-way VPC network:
gcloud compute routes list --filter "network: kubernetes-the-hard-way"
