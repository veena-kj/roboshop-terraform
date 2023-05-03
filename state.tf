terraform {
  backend "s3" {
    bucket = "vterraform"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}