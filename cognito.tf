resource "aws_cognito_user_pool" "main" {
  name = "${var.domain_name}-cognito-user-pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = {
    "Automation" = "Terraform"
  }
}

resource "aws_cognito_user_pool_domain" "cognito-user-pool-domain" {
  domain       = var.domain_name
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user" "admin" {
  user_pool_id = aws_cognito_user_pool.main.id
  username     = var.admin_email

  lifecycle {
    ignore_changes = [
      attributes
    ]
  }
}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${var.domain_name}-cognito-identity-pool"
  allow_unauthenticated_identities = false

  lifecycle {
    ignore_changes = [
      cognito_identity_providers
    ]
  }
}

# IAM role for Authenticated Cognito Users
resource "aws_iam_role" "cognito_authenticated" {
  name               = "${var.domain_name}-cognito-authenticated"
  assume_role_policy = data.aws_iam_policy_document.cognito_authenticated_trust.json

  tags = {
    "Automation" = "Terraform"
  }
}

data "aws_iam_policy_document" "cognito_authenticated_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.within_govcloud ? "cognito-identity-us-gov.amazonaws.com" : "cognito-identity.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = var.within_govcloud ? "cognito-identity-us-gov.amazonaws.com:aud" : "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.main.id]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = var.within_govcloud ? "cognito-identity-us-gov.amazonaws.com:amr" : "cognito-identity.amazonaws.com:amr"
      values   = ["authenticated"]
    }
  }
}

resource "aws_iam_role_policy" "cognito_authenticated_permission" {
  name = "${var.domain_name}-cognito-authenticated-permissions"
  role = aws_iam_role.cognito_authenticated.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}


resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.main.id

  roles = {
    "authenticated" = aws_iam_role.cognito_authenticated.arn
  }
}

# IAM role that connects Cognito and OpenSearch
resource "aws_iam_role" "cognito_to_opensearch" {
  name               = "${var.domain_name}-opensearch-cognito"
  assume_role_policy = data.aws_iam_policy_document.cognito_to_opensearch_trust.json

  tags = {
    "Automation" = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "cognito_to_opensearch_permissions" {
  role       = aws_iam_role.cognito_to_opensearch.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonOpenSearchServiceCognitoAccess"
}

data "aws_iam_policy_document" "cognito_to_opensearch_trust" {
  statement {
    sid = ""

    actions = ["sts:AssumeRole"]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }
  }
}
