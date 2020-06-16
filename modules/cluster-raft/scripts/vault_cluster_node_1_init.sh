#!/bin/bash
set -e
sudo ls -la /etc/vault.d/
sudo systemctl start vault &&  \
sleep 10s && \
systemctl status vault && \
vault operator init -address=http://127.0.0.1:8200 |  \
awk '/Root Token/{print $4}' | \
sudo tee /root/root_token && \
sleep 10s