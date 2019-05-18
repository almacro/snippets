#!/usr/bin/env bash
#
# generate CA configuration file, certificate and private key

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

# 2019/05/16 23:22:48 [INFO] generating a new CA key and certificate from CSR
# 2019/05/16 23:22:48 [INFO] generate received request
# 2019/05/16 23:22:48 [INFO] received CSR
# 2019/05/16 23:22:48 [INFO] generating key: rsa-2048
# 2019/05/16 23:22:49 [INFO] encoded CSR
# 2019/05/16 23:22:49 [INFO] signed certificate with serial number 91090840768351470929985464465796357252523469097
