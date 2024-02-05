# S3 Bucket Configuration
resource "aws_s3_bucket" "example_bucket" {
  bucket_prefix = "example-bucket"

  # Prevent deletion of bucket contents from Terraform
  #   force_destroy = false

  # Deprecated
  #   website {
  #     index_document = "index.html"
  #     error_document = "error.html"
  #   }  
}

# S3 Bucket Policy Configuration
resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = aws_s3_bucket.example_bucket.id
  policy = data.aws_iam_policy_document.example_s3_policy.json
}

# S3 Policy Configuration
data "aws_iam_policy_document" "example_s3_policy" {
  statement {
    sid    = "Allow CloudFront"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.example-cf-identity.iam_arn]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.example_bucket.arn}/*"
    ]
  }
}

# S3 Website Configuration
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

# S3 Object Upload - Index Page
resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.example_bucket.id
  key          = "index.html"
  source       = "resources/index.html"
  content_type = "text/html"
}

# S3 Object Upload - Error Page
resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.example_bucket.id
  key          = "error.html"
  source       = "resources/error.html"
  content_type = "text/html"
}
