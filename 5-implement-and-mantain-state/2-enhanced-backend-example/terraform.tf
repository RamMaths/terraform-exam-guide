terraform {
  required_version = ">= 1.0.0"

  backend "remote" {
    hostname  = "app.terraform.io"
    organization = "RamsesMata"
    workspaces {
      name = "my-aws-app"
    }
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
