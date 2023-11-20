resource "aws_cloudfront_distribution" "cloud-cv-tf" {
  origin {
    #
    # WEBSITE ENDPOINT IS DEPRECEATED!
    #
    domain_name = aws_s3_bucket_website_configuration.cloud-cv-tf.website_endpoint
    origin_id = "S3-${var.cv_bucket_name}"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1"]
    }
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  aliases = ["www.tf.cv.gatherer.tech", "tf.cv.gatherer.tech"]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "S3-${var.cv_bucket_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      # Come back to this later to update
      locations = ["US", "CA", "GB", "DE", "FR"]
    }
  }

  tags = var.global_tags

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cloud-cv-tf.arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method = "sni-only"
  }


}