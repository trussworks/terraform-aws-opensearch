# terraform-aws-opensearch

Creates and OpenSearch cluster and a corresponding user pool and identity pool in Cognito for access.

## Terraform Versions

Terraform 1.1. Pin module version to ~> 1.0. Submit pull-requests to main branch.

## Usage

### Put an example usage of the module here

```hcl
module "opensearch" {
  source = "trussworks/opensearch/aws"

  domain_name = "my-domain-name"
  admin_email = "my-admin-email"
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=  1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool) | resource |
| [aws_cognito_identity_pool_roles_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool_roles_attachment) | resource |
| [aws_cognito_user.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user) | resource |
| [aws_cognito_user_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_domain.cognito-user-pool-domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_elasticsearch_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain) | resource |
| [aws_iam_role.cognito_authenticated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cognito_to_opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cognito_authenticated_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cognito_to_opensearch_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cognito_authenticated_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_to_opensearch_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_email"></a> [admin\_email](#input\_admin\_email) | Email for the admin user for the OpenSearch domain. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the OpenSearch domain. | `string` | n/a | yes |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | Volume size of Elastic Block Store. | `number` | `10` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | Type of volume for Elastic Block Store. | `string` | `"gp2"` | no |
| <a name="input_enable_ebs"></a> [enable\_ebs](#input\_enable\_ebs) | Enable Elastic Block Store in OpenSearch domain. | `bool` | `true` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to use for OpenSearch cluster. | `string` | `"t3.small.elasticsearch"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Number of days to retain logs. | `number` | `30` | no |
| <a name="input_opensearch_version"></a> [opensearch\_version](#input\_opensearch\_version) | Version of OpenSearch to use. | `string` | `"OpenSearch_1.2"` | no |
| <a name="input_within_govcloud"></a> [within\_govcloud](#input\_within\_govcloud) | Is Cognito and OpenSearch being set up in AWS GovCloud? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_opensearch_arn"></a> [opensearch\_arn](#output\_opensearch\_arn) | OpenSearch ARN |
| <a name="output_opensearch_id"></a> [opensearch\_id](#output\_opensearch\_id) | OpenSearch ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit go terraform terraform-docs
pre-commit install --install-hooks
```

### Testing

[Terratest](https://github.com/gruntwork-io/terratest) is being used for
automated testing with this module. Tests in the `test` folder can be run
locally by running the following command:

```text
make test
```

Or with aws-vault:

```text
AWS_VAULT_KEYCHAIN_NAME=<NAME> aws-vault exec <PROFILE> -- make test
```
