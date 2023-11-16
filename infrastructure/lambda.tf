resource "aws_lambda_function" "cloud-cv-tf" {

    filename            = data.archive_file.zip.output_path
    source_code_hash    = data.archive_file.zip.output_base64sha256
    function_name       = "lambda_function_tf"
    role                = aws_iam_role.iam_for_lambda.arn
    handler             = "func.handler"
    runtime             = "python3.8" 
}

data "archive_file" "zip" {
    type = "zip"
    source_dir = "${path.module}/lambda/"
    output_path = "${path.module}/packedLambda.zip"
}

resource "aws_lambda_function_url" "url1" {
  function_name = aws_lambda_function.cloud-cv-tf.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins = ["*"]
    allow_headers = ["date", "keep-alive"]
    allow_methods = ["*"]
    expose_headers = ["keep-alive", "date"]
    max_age = 86400
  }
}