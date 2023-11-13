resource "aws_lambda_function" "cloud-cv-tf" {

    filename            = data.archive_file.zip.output_path
    source_code_hash    = data.archive_file.zip.output_base64sha256
    function_name       = "lambda_function_tf"
    role                = aws_iam_role.iam_for_lambda.arn
    handler             = "func.handler"
    runtime             = "python3.8" 
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy =  <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_cloud_cv_tf" {
  name = "aws_iam_policy_for_cloud_cv_tf"
  path = "/"
  description = "AWS IAM policy for managing the cloud cv project role"
  policy = jsonencode(
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                "Resource": "arn:aws:logs:*:*:*",
                "Effect": "Allow"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "dynamodb:UpdateItem",
                    "dynamodb:GetItem"
                ],
                "Resrouce": "arn:aws:dynamodb:*:*:table/cloud-cv-tf"
            }
        ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_cloud_cv_tf.arn
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