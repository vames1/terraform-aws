resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket-725115072836"

  tags = {
    Name        = "MyTerraformBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
