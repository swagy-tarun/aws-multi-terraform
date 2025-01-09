terraform {
  backend "s3" {
    bucket = "preprod-networking-tf"
    key = "network/terraform.tfstate"
    region = "ap-south-1"
    profile = "pb-prod-network-account"
    encrypt = true
  }
}