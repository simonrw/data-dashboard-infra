terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_dynamodb_table" "lock-table" {
  name = "terraform-state-lock"

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

  billing_mode = "PAY_PER_REQUEST"
}

module "secret-value-tenant-id" {
  source = "../secret"
  name   = "aws/auth/ukhsa-tenant-id"
  value  = "foo"
}

module "secret-value-client-id" {
  source = "../secret"
  name   = "aws/auth/ukhsa-client-id"
  value  = "foo"
}

module "secret-value-client-secret" {
  source = "../secret"
  name   = "aws/auth/ukhsa-client-secret"
  value  = "foo"
}

module "secret-value-dev-account-id" {
  source = "../secret"
  name   = "aws/account-id/dev"
  value  = "000000000000"
}

module "secret-value-etl-dev-account-id" {
  source = "../secret"
  name   = "aws/account-id/etl-dev"
  value  = "000000000000"
}

