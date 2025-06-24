resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "email-validator-ui-${random_id.bucket_suffix.hex}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = "EmailValidatorFrontend"
  }
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.frontend_bucket.arn}/*"
      }
    ]
  })
}

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
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "EmailValidatorFrontendCDN"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
