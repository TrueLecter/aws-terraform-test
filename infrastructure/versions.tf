terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.0.0"
    }

    time = {
      source = "hashicorp/time"
      version = "0.7.1"
    }

  }

  required_version = ">= 0.14.9"
}