terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.65.0"
    }    
  }

  backend "s3" {
    bucket = "stack-k8s-terraform-backend"
    key = "build/terraform.tfstate"
    region = "eu-west-2"
    profile = "emma"
    
  }
}

provider "aws" {
  # Configuration options  
  region = "eu-west-2"
  
}