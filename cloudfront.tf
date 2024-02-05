# CloudFront Distribution Configuration
resource "aws_cloudfront_distribution" "example-cf" {
  # Access to S3
  origin {
    domain_name = aws_s3_bucket.example_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.example_bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.example-cf-identity.cloudfront_access_identity_path
    }
  }

  # Point to ALB
  origin {
    domain_name = aws_lb.example_alb.dns_name
    origin_id   = aws_lb.example_alb.id
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      # Communication between CloudFront and ALB
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 60
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  # Access control
  enabled = true

  # Object returned to users with permission when 'enabled'
  # default_root_object = "index.html"

  # ALB Cache Settings
  default_cache_behavior {
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = aws_lb.example_alb.id

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
      headers = ["*"]
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 10
    max_ttl                = 60
  }

  # S3 Cache Settings
  ordered_cache_behavior {
    # HTTP methods for redirecting to S3
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.example_bucket.id

    # Number of queries, whether to use cookies or not
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    # Allow request compression
    compress               = true
    # Redirect to HTTPS
    viewer_protocol_policy = "redirect-to-https"
    # Minimum time to check the cache stored in CloudFront
    min_ttl                = 0
    # Default time - Is the minimum time necessary?
    default_ttl            = 3600
    # Maximum time
    max_ttl                = 86400
    path_pattern           = "/resources/*"
  }

  # Delivery Region Restrictions
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }
  # SSL Certificate - Required for HTTPS
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# CloudFront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "example-cf-identity" {}
