resource "aws_dynamodb_table" "cloud-cv-tf" {
  name = "db-cloud-cv-tf"
  billing_mode = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "ViewCount"
    type = "N"
  }

  ttl {
    attribute_name = "TimetoExist"
    enabled = false
  }

  tags = {
    name = "cloud-cv-tf"
    }

}