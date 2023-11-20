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


resource "aws_route53_record" "dns_validation" {
   for_each = {
       for dvo in aws_acm_certificate.cloud-cv-tf.domain_validation_options : dvo.domain_name => {
       name   = dvo.resource_record_name
       record = dvo.resource_record_value
       type   = dvo.resource_record_type
       }
   }

   allow_overwrite = true
   name = each.value.name
   records = [each.value.record]
   ttl = 60
   type = each.value.type
   zone_id = var.dns_zone_id
  
}

resource "aws_acm_certificate_validation" "cloud-cv-tf" {
  # Using the us-east-1 provider
  provider = aws.acm_provider
  certificate_arn = aws_acm_certificate.cloud-cv-tf.arn
  validation_record_fqdns = [for record in aws_route53_records.dns_validation : record.fqdn]
  }