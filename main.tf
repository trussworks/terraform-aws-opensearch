data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

# The Opensearch Cluster
resource "aws_elasticsearch_domain" "main" {
  domain_name           = var.domain_name
  elasticsearch_version = var.opensearch_version

  access_policies = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "es:*"
          ]
          Effect = "Allow"
          Principal = {
            AWS = "*"
          }
          Resource = "arn:${data.aws_partition.current.partition}:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
        }
      ]
    }
  )

  # tells OpenSearch to use Cognito for authentication
  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = false

    master_user_options {
      master_user_arn = aws_iam_role.cognito_authenticated.arn
    }
  }

  cluster_config {
    instance_type = var.instance_type
  }

  # tells what role OpenSearch uses to utilize Cognito
  cognito_options {
    enabled          = true
    identity_pool_id = aws_cognito_identity_pool.main.id
    role_arn         = aws_iam_role.cognito_to_opensearch.arn
    user_pool_id     = aws_cognito_user_pool.main.id
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = var.enable_ebs
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  tags = {
    "Automation" = "Terraform"
  }
}
