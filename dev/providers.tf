# Be sure to have ran init.tf first
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    profile                  = "vscode"

    bucket = "${bucket_name}"
    key    = "terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform_state"
    encrypt        = true
  }
}
