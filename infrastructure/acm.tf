resource "aws_acm_certificate" "cloud-cv-tf" {
  provider = aws.acm_provider
  domain_name = var.domain
  subject_alternative_names = ["www.${var.domain}"]
  validation_method = "DNS"

  tags = var.global_tags

  lifecycle {
    create_before_destroy = true
  }
}