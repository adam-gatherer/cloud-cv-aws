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