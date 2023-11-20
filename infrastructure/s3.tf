resource "random_string" "random" {
  length = 4
  special = false
  lower = true
  upper = false
  numeric = true
}

resource "aws_s3_bucket" "cloud-cv-tf" {
  bucket = "${random_string.random.result}-${var.cv_bucket_name}"
  tags = var.global_tags
}

data "aws_iam_policy_document" "cloud-cv-tf" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.cloud-cv-tf.arn}/*"]

    principals {
      type = "*"
      identifiers = ["*"]
    }
  }
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