terraform {
  backend "s3" {
    bucket = "lyndale-investments-llc"
    key    = "terraform-backend"
    region = "us-east-1"
  }
}
