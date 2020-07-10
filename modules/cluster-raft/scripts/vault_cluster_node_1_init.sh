#!/bin/bash
set -e
sudo ls -la /etc/vault.d/
sudo systemctl start vault && \
vault status -address=http://127.0.0.1:8200 | grep -q 'Initialized *true' && exit 0 || {
  sleep 10s && \
  systemctl status vault && \
  vault operator init -address=http://127.0.0.1:8200 | \
  awk '/Root Token/{print $4}' | \
  sudo tee /root/root_token
}
sleep 10s
export VAULT_TOKEN=`sudo cat /root/root_token` VAULT_ADDR=http://127.0.0.1:8200 && \
vault secrets enable -path=secret kv-v2 && \
vault secrets enable pki && \
vault write pki/root/generate/internal common_name=vault.service.consul ttl=87600h && \
vault write pki/config/urls issuing_certificates="http://vault.service.consul:8200/v1/pki/ca" crl_distribution_points="http://vault.service.consul:8200/v1/pki/crl" && \
vault write pki/roles/consul \
    allowed_domains=consul \
    allow_subdomains=true max_ttl=72h