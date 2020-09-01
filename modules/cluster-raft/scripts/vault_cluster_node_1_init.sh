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
#### consul/connect/nomad pki
vault secrets enable -path=tls_pki pki && \
vault secrets tune -max-lease-ttl=8760h tls_pki && \
vault write tls_pki/roles/external_web_poc allowed_domains="poc" allow_subdomains=true allow_glob_domains=true max_ttl=8760h && \
vault write -field=certificate tls_pki/root/generate/internal common_name="consul" ttl=8760h && \
vault write tls_pki/config/urls issuing_certificates="http://127.0.0.1:8200/v1/tls_pki/ca" crl_distribution_points="http://127.0.0.1:8200/v1/tls_pki/crl" && \
vault secrets enable -path=tls_pki_int pki && \
vault secrets tune -max-lease-ttl=43800h tls_pki_int && \
vault write -format=json tls_pki_int/intermediate/generate/internal common_name="consul Intermediate Authority" alt_names="localhost,127.0.0.1" ip_sans="127.0.0.1" | jq -r '.data.csr' | tee tls_pki_intermediate.csr && \
vault write -format=json tls_pki/root/sign-intermediate csr=@tls_pki_intermediate.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' | tee intermediate.cert.pem && \
vault write tls_pki_int/intermediate/set-signed certificate=@intermediate.cert.pem && \
vault write tls_pki_int/roles/consul allowed_domains="consul,127.0.0.1" allow_subdomains=true max_ttl="720h" && \
vault write tls_pki_int/roles/nomad allowed_domains="nomad,127.0.0.1" allow_subdomains=true max_ttl="720h" && \
rm tls_pki_intermediate.csr intermediate.cert.pem





