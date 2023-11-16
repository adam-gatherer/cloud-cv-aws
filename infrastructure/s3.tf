resource "aws_s3_bucket" "cloud-cv-tf" {
  bucket = "s3-cloud-cv-tf"
  tags ={
    Name = "s3-cloud-cv-tf"
  }

  cors_rule {
    
  }

}


resource "aws_s3_bucket_website_configuration" "cloud-cv-tf" {
  bucket = aws_s3_bucket.cloud-cv-tf.id

  index_document {
    suffix = "index.html"
  }


}