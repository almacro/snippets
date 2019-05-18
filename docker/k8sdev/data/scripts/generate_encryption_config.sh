#!/usr/bin/env bash
#
# generate an encryption key and config for encrypting Kubernetes secrets

ENCRYPTION_KEY=$(openssl rand -base64 32)

cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
