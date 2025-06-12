terraform {
  backend "s3" {
    bucket = "terraform-backend-terraformbbackends3bucket-ynqax1cfz9ow"
    key = "web-server"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-1MKII9GK8CJ11"
    region = "us-east-1"
  }
}