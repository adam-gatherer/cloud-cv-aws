resource "random_string" "random" {
  length = 4
  special = false
  lower = true
  upper = false
  numeric = true
}

resource "aws_s3_bucket" "cloud-cv-tf" {
  bucket = "${random_string.random.result}-${var.cv_bucket_name}"
  tags ={
    Name = "s3-cloud-cv-tf"
  }
}

resource "aws_s3_bucket_website_configuration" "cloud-cv-tf" {
  bucket = aws_s3_bucket.cloud-cv-tf.id

  index_document {
    suffix = "index.html"
  }


}