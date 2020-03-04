terraform {
  backend "s3" {
    bucket = "cloudmargintfstate"
    key    = "cloudmargintfstate/"
    region = "eu-west-1"
  }
}
provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}