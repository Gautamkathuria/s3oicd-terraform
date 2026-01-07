data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket = "myapp-${var.env}-bucket-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "myapp-${var.env}-bucket"
    Environment = var.env
  }
}

# Recommended: block public access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

