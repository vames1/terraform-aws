resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket-${terraform.workspace}-725115072836"

  tags = {
    Name        = "MyTerraformBucket"
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
