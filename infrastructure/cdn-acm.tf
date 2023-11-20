resource "aws_cloudfront_distribution" "cloud-cv-tf" {
    origin {
        domain_name = aws_s3_bucket.cloud-cv-tf.s3_website_endpoint
        origin_id   = "OriginaName"
        custom_origin_config {
          
          origin_ssl_protocols          = ["TLSv1", "TLSv1.1", "TLSv1.2"]
          http_port                     = 80
          https_port                    = 443
          origin_keepalive_timeout      = 5
          origin_protocol_policy        = "http-only"
        }
    }
    viewer_certificate {
      
      acm_certificate_arn   = aws_acm_certificate.cloud-cv-tf.acm_certificate_arn
      ssl_support_method    = "sni-only"
    }
    enabled         = true
    is_ipv6_enabled = true
    restrictions {
      
      geo_restriction {
        restriction_type = "none"
      }
    }
    aliases = ["tf.cv.gatherer.tech", "www.tf.cv.gatherer.tech"]
    default_cache_behavior {
      target_origin_id          = "OriginName"
      viewer_protocol_policy    = "redirect-to-https"
      allowed_methods           = ["GET", "HEAD", "OPTIONS"]
      cached_methods            = ["GET", "HEAD", "OPTIONS"]
      min_ttl                   = 0
      default_ttl               = 0
      max_ttl                   = 0
      forwarded_values {
        query_string    = false
        headers         = ["*"]
        cookies {
          forward = "none"
        }
      }
    }
}

resource "aws_cloudfront_origin_access_identity" "cloud-cv-tf" {
  comment = "OAI for cv website"
}

resource "aws_acm_certificate" "cloud-cv-tf" {
  domain_name               = "tf.cv.gatherer.tech"
  subject_alternative_names = ["*.tf.cv.gatherer.tech"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
    }
}