terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}
provider "aws" {
  region  = "us-east-1" # Or your desired AWS region
  profile = "Terraform" # Explicitly tell Terraform to use the 'Terraform' profile
  default_tags {
    tags = {
      Environment = "Development"
      Project = "Web-Server"
    }
  }
}
