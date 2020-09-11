# Vault provisioning and management modules

## Raft cluster provisioning module (cluster-raft)

This module helps to provision a vault cluster that uses built-in raft-storage. The provisioning is relies on remote-exec capability via SSH. The intended usage is a bootstrap procedure when compute instances are being formed. The module takes the connectivity configuration from the caller to contact the compute nodes and install the cluster. The cluster is initialized and configured to auto-unseal used one of the three supported methods:
  - GCP
  - OCI
  - Vault transit

### Module parameters:

**Connectivity**
 - `cluster_nodes`: required, a map in form of "node-name" => "node's private IP" of the nodes to provision the cluster on. Usually it is passed from the cloud instance resources.
 - `cluster_nodes_public_ips`: if the instances should be reached via public IPs this map will be used instead of the one above to SSH into the nodes
 - `vault_home` : where the vault's data is kept on the nodes (`/var/lib/vault`)
 - `ssh_private_key`: required, the private key to use for SSH connection to cluster nodes
 - `ssh_user`: default is "centos"
 - `ssh_timeout`: default is 60s
 - `ssh_bastion_host`: bastion is supported
 - `ssh_bastion_port`: default is "22"
 - `ssh_bastion_private_key`: the private key to use to login into bastion
 - `ssh_bastion_user`

**Auto-Unseal**
 - `unseal_type`: "gcp" or "oci", the default is "gcp"
 - `unseal_region`: the region where unseal is if applicable, defaults to "global"
 - `unseal_keyring`: unseal keyring name, defaults to "vault_unseal_keyring"
 - `unseal_key`: the name of the key to use for auto unseal, defaults to "vault_unseal_keyring"
 - `unseal_project_id`: the ID of the project if needed, defaults to an empty string

**Internals**
 - `cluster_nodes_ids`: required, list of strings which are IDs of the instance resources and are used to `trigger` the provisioning of `null` resources on instance recreation

These parameters below have defaults set to null so the values can be omitted if called for a different provider but for the provider in use its parameters are all required.

**GCP Auto unseal**

 - `gcp_node_role`: configured GCP role of the node
 - `gcp_service_account`: configured GCP service account
 - `gcp_project_id`: the GCP Project ID

**OCI**

 - `unseal_crypto_endpoint`: the OCI Vault crypto endpoint
 - `unseal_management_endpoint`: the OCI Vault management endpoint

**Transit**

 - `unseal_transit_vault_address`: the Vault address for transit auto unseal
 - `unseal_transit_mount_path`: the Vault transit engine mount path for transit auto unseal
 - `unseal_transit_vault_token`: the Vault token to access transit engine mount path for transit auto unseal
