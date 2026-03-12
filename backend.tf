terraform {
  backend "s3" {
    bucket = "terraform-state-725115072836"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
