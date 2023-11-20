terraform {
    required_providers {
      aws = {
        version = "~>4.9.0"
        source = "hashicorp/aws"
      }
      random = {
        verson = "~>3.1.0"
        source = "hashicorp/random"
      }
    }
}

provider "aws" {
    region = "eu-west-1"
}


terraform {
  backend "s3" {
    bucket = "cloud-cv-tf-state"
    region = "eu-west-1"
    key = "state/main"
  }
}