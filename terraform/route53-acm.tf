resource "aws_route53_zone" "primary" {
  name = "yourdomain.com"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "email.yourdomain.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "email-validator-cert"
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  zone_id = aws_route53_zone.primary.zone_id
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
