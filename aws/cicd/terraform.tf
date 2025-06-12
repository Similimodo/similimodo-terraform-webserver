terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "terraform-backend-terraformbbackends3bucket-ynqax1cfz9ow  "
    key            = "Development"
    region         = "us-east-1"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-1MKII9GK8CJ11"
  }
}

provider "aws" {
  default_tags {
    tags = {
      "Environment" = "Development"
      "Project"     = "Terraform"
      "Operation"   = "CICD"
    }
  }
}