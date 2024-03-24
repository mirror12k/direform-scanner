# cf distribution fronting the website, enable when useful
variable "domain_acm_cert_arn" { type = string }
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.bucket_website_configuration.website_endpoint
    # domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
    # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = "website_origin"
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = [
        "TLSv1.1",
      ]
    }
  }
}
