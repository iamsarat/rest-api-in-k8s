terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "demo-us-east-2-azby"
    key            = "demo.tfstate"
    dynamodb_table = "demo-us-east-2-azby"
    encrypt        = true
  }
}
