terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket  = "prueba-terraform-rmata-001"
    key     = "prod/aws_infra"
    region  = "us-east-1"
    profile = "ramses"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}
