resource "random_string" "random" {
  length = 4
  special = false
  lower = true
  upper = false
}

resource "aws_s3_bucket" "cloud-cv-tf" {
  # Uses random string to ensure globally unique bucket name
  bucket = "${random_string.random.result}-${var.cv_bucket_name}"
  tags = var.global_tags
}

data "aws_iam_policy_document" "cloud-cv-tf" {
  # Policy to permit GetObject actions on the bucket
  statement {
    actions = ["s3:GetObject"]
    # Identifies the bucket by its property
    resources = ["${aws_s3_bucket.cloud-cv-tf.arn}/*"]

    principals {
      type = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "cloud-cv-tf" {
  # Applies the policy to the bucket
  bucket = aws_s3_bucket.cloud-cv-tf.id
  policy = data.aws_iam_policy_document.cloud-cv-tf.json
}


resource "aws_s3_bucket_website_configuration" "cloud-cv-tf" {
  
  bucket = aws_s3_bucket.cloud-cv-tf.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }


}