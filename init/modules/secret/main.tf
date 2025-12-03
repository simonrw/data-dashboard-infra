terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "name" {
}

variable "value" {
}


resource "aws_secretsmanager_secret" "secret" {
  name = var.name
}

resource "aws_secretsmanager_secret_version" "secret-value" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = var.value
}
