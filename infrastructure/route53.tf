resource "aws_route53_record" "cloud-cv-tf" {
  # Uses r53 DNS zone ID from variables
  zone_id = var.dns_zone_id
  # Uses domain name from variables
  name = var.domain
  # Specifies address record 
  type = "A"

  alias {
    name = aws_cloudfront_distribution.cloud-cv-tf.domain_name
    zone_id = aws_cloudfront_distribution.cloud-cv-tf.hosted_zone_id
    evaluate_target_health = true
  }
}