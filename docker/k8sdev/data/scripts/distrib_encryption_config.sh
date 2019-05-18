#!/usr/bin/env bash
#
# distribute encryption config for encrypting Kubernetes secrets

for instance in controller-0 controller-1 controller-2
do
  gcloud compute scp encryption-config.yaml ${instance}:~/
done
