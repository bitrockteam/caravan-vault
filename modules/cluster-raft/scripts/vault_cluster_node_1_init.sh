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
vault secrets tune -max-lease-ttl=87600h pki && \
vault write -field=certificate pki/root/generate/internal common_name="service.consul" ttl=87600h && \
vault write pki/config/urls issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl" && \
vault secrets enable -path=pki_int pki && \
vault secrets tune -max-lease-ttl=43800h pki_int && \
vault write -format=json pki_int/intermediate/generate/internal common_name="consul Intermediate Authority" | jq -r '.data.csr' | tee pki_intermediate.csr && \
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' | tee intermediate.cert.pem && \
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem && \
vault write pki_int/roles/consul allowed_domains="service.consul" allow_subdomains=true max_ttl="720h" && \
rm pki_intermediate.csr intermediate.cert.pem
##### this in the oven, look at consul tmpl #####
# {{ with secret "pki_int/issue/consul" "common_name=consul" "ttl=24h" }}
# {{ .Data.certificate }}
# {{ .Data.issuing_ca }}
# {{ .Data.private_key }}
# {{ end }}



# vault write pki/root/generate/internal common_name=vault.service.consul ttl=87600h && \
# vault write pki/config/urls issuing_certificates="http://vault.service.consul:8200/v1/pki/ca" crl_distribution_points="http://vault.service.consul:8200/v1/pki/crl" && \
# vault write pki/roles/consul \
#     allowed_domains=consul \
#     allow_subdomains=true max_ttl=72h




