terraform {
  backend "s3" {
    bucket = "cloudmargintfstate"
    key    = "cloudmargintfstate/"
    region = "eu-west-1"
  }
}