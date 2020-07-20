#! /bin/bash

set -e

export VAULT_TOKEN=`sudo cat /root/root_token` VAULT_ADDR=http://127.0.0.1:8200 && \
vault write -format=json pki_int/issue/consul common_name="consul" ttl="168h" | tee certs.json && \
cat certs.json | jq -r .data.issuing_ca | sudo tee /etc/consul.d/ca && \
cat certs.json | jq -r .data.certificate | sudo tee /etc/consul.d/cert && \
cat certs.json | jq -r .data.private_key | sudo tee /etc/consul.d/keyfile && \
sudo chown vault:consul /etc/consul.d/ca /etc/consul.d/cert /etc/consul.d/keyfile
rm -rf certs.json