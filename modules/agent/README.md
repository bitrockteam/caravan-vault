# Agent module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| approle\_auto\_auth | (optional) Should agent auto authenticate via AppRole | `bool` | `false` | no |
| aws\_access\_key | (optional) Static AWS Access Key credential for authentication | `string` | `null` | no |
| aws\_auto\_auth | (optional) Should agent auto authenticate via AWS's IAM | `bool` | `false` | no |
| aws\_node\_role | (optional) Configured AWS role of the node | `string` | `null` | no |
| aws\_secret\_key | (optional) Static AWS Secret Key credential for authentication | `string` | `null` | no |
| azure\_auto\_auth | (optional) Should agent auto authenticate via Azure's IAM | `bool` | `false` | no |
| azure\_node\_role | (optional) Configured Azure role of the node | `string` | `null` | no |
| azure\_resource | (optional) A configured Azure AD application which is used as the resource for generating MSI access tokens | `string` | `"https://management.azure.com/"` | no |
| gcp\_auto\_auth | (optional) Should agent auto authenticate via GCP's IAM | `bool` | `false` | no |
| gcp\_node\_role | (optional) Configured GCP role of the node | `string` | `null` | no |
| gcp\_project\_id | (optional) The GCP Project ID | `string` | `null` | no |
| gcp\_service\_account | (optional) Configured GCP service account | `string` | `null` | no |
| nodes | (required) map of node => ip | `map(any)` | n/a | yes |
| nodes\_ids | (required) IDs of nodes to trigger reprovision of agents | `list(string)` | n/a | yes |
| nodes\_public\_ips | (optional) map of node => public ip | `map(any)` | `null` | no |
| oci\_auto\_auth | (optional) Should agent auto authenticate via OCI's IAM | `bool` | `false` | no |
| oci\_node\_role | (optional) Configured OCI role of the node | `string` | `null` | no |
| ssh\_bastion\_host | n/a | `string` | `null` | no |
| ssh\_bastion\_port | n/a | `string` | `"22"` | no |
| ssh\_bastion\_private\_key | n/a | `string` | `null` | no |
| ssh\_bastion\_user | n/a | `string` | `null` | no |
| ssh\_private\_key | n/a | `string` | n/a | yes |
| ssh\_timeout | n/a | `string` | `"60s"` | no |
| ssh\_user | n/a | `string` | `"centos"` | no |
| tcp\_listener | (optional) Where agent should bind in form of host:port | `string` | `"127.0.0.1:9200"` | no |
| tcp\_listener\_tls | (optional) Should TLS be enabled on TCP listener | `bool` | `false` | no |
| vault\_endpoint | (required) Where the vault server is | `string` | n/a | yes |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
