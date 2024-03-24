
resource "aws_s3_bucket" "bucket" {
  bucket = "hello-world-bucket"
  force_destroy = true
}


