terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  alias = "us-east-1"
  region = "us-east-1"
  s3_use_path_style = true
}


provider "aws" {
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  alias = "eu-west-2"
  region = "eu-west-2"
  s3_use_path_style = true
}

# unique resources
resource "aws_s3_bucket" "state" {
  bucket = "uhd-terraform-states"
  provider = aws.us-east-1
}

resource "aws_iam_role" "terraform-role" {
  for_each = toset(["TerraformOperator", "ReportViewer"])
  name = each.key

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::000000000000:root"
        }
      },
    ]
  })
}

# per-region resources
module "setup-infra-us-east-1" {
  source = "./modules/setup"

  providers = {
    aws = aws.us-east-1
  }
}

module "setup-infra-eu-west-2" {
  source = "./modules/setup"

  providers = {
    aws = aws.eu-west-2
  }
}
