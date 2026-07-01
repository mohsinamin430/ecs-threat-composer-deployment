terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.45.0"
    }
  }
}

provider "aws" {
    region = var.region
}


#Terraform backend configuration for storing state in S3
terraform {
  backend "s3" {
    bucket = "tfstate-threatapp"
    key    = "global/state/terraform.tfstate"
    region = var.region
    encrypt = true
    use_lockfile = true
  }
}