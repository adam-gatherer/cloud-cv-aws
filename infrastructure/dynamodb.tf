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

  ttl {
    attribute_name = "TimetoExist"
    enabled = false
  }

  tags = {
    name = "cloud-cv-tf"
    }

}

resource "aws_dynamodb_table_item" "clouc-cv-tf" {
  table_name = aws_dynamodb_table.cloud-cv-tf.name
  hash_key = aws_dynamodb_table.cloud-cv-tf.hash_key

  item = <<ITEM
  {
    "id": {"S": "1"},
    "ViewCount": {"N": "0"}
  }
  ITEM
}