resource "aws_s3_bucket" "cloud-cv-tf" {
  bucket = "adam-gatherer-cloud-cv-tf"
  acl = "private"
  tags ={
    Name = "adam-gatherer-cloud-cv-tf"
  }
}