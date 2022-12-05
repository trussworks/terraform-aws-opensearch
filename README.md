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

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.1.0 |
| aws       | ~> 4.0   |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | ~> 4.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                       | Type        |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cognito_identity_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool)                                        | resource    |
| [aws_cognito_identity_pool_roles_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool_roles_attachment)      | resource    |
| [aws_cognito_user.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user)                                                         | resource    |
| [aws_cognito_user_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool)                                                | resource    |
| [aws_cognito_user_pool_domain.cognito-user-pool-domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain)              | resource    |
| [aws_elasticsearch_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain)                                          | resource    |
| [aws_iam_role.cognito_authenticated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                 | resource    |
| [aws_iam_role.cognito_to_opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                 | resource    |
| [aws_iam_role_policy.cognito_authenticated_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                        | resource    |
| [aws_iam_role_policy_attachment.cognito_to_opensearch_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                              | data source |
| [aws_iam_policy_document.cognito_authenticated_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                  | data source |
| [aws_iam_policy_document.cognito_to_opensearch_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                  | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition)                                                          | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                                                | data source |

## Inputs

| Name               | Description                                             | Type     | Default                    | Required |
| ------------------ | ------------------------------------------------------- | -------- | -------------------------- | :------: |
| admin_email        | Email for the admin user for the OpenSearch domain.     | `string` | n/a                        |   yes    |
| domain_name        | Name of the OpenSearch domain.                          | `string` | n/a                        |   yes    |
| ebs_volume_size    | Volume size of Elastic Block Store.                     | `number` | `10`                       |    no    |
| ebs_volume_type    | Type of volume for Elastic Block Store.                 | `string` | `"gp2"`                    |    no    |
| enable_ebs         | Enable Elastic Block Store in OpenSearch domain.        | `bool`   | `true`                     |    no    |
| instance_type      | Type of instance to use for OpenSearch cluster.         | `string` | `"t3.small.elasticsearch"` |    no    |
| log_retention_days | Number of days to retain logs.                          | `number` | `30`                       |    no    |
| opensearch_version | Version of OpenSearch to use.                           | `string` | `"OpenSearch_1.2"`         |    no    |
| within_govcloud    | Is Cognito and OpenSearch being set up in AWS GovCloud? | `bool`   | `false`                    |    no    |

## Outputs

| Name           | Description    |
| -------------- | -------------- |
| opensearch_arn | OpenSearch ARN |
| opensearch_id  | OpenSearch ID  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit go terraform terraform-docs
pre-commit install --install-hooks
```
