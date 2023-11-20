terraform {
    required_providers {
      aws = {
        version = "~> 4.9.0"
        source = "hashicorp/aws"
      }
      random = {
        version = "~> 3.1.0"
        source = "hashicorp/random"
      }
    }
}

provider "aws" {
  # Used for main bulk of services
  region = "eu-west-1"
}

provider "aws" {
  # Used as ACM only available on us-east-1
  alias = "acm_provider"
  region = "us-east-1"
}


terraform {
  backend "s3" {
    # Stores tf state file in private bucket
    bucket = "adam-gatherer-cloud-cv-tf"
    region = "eu-west-1"
    key = "state/main"
  }
}