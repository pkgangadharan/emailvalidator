resource "aws_cloudfront_distribution" "frontend_distribution" {
  origin {
    domain_name = aws_s3_bucket.frontend_bucket.website_endpoint
    origin_id   = "S3-Origin"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_sslProtocols    = ["TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["email.yourdomain.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "EmailValidatorFrontendCDN"
  }

  depends_on = [aws_acm_certificate_validation.cert_validation]
}
