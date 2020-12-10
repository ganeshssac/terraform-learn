terraform {
  backend "s3" {
    bucket = "terraformstate-ganesh"
    key    = "terraform/demo4"
    region = "eu-west-1"

  }
}