terraform {
  backend "local" {}
}

provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "eu-west-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3     = "http://localhost:4572"
    lambda = "http://localhost:4574"
    iam    = "http://localhost:4593"
  }
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "example-bucket"
  acl    = "private"
}


resource "aws_lambda_function" "example" {
  function_name = "lowest-common-ancestor-localstack"
  description   = "lowest-common-ancestor-localstack"
  runtime       = "python3.8"
  handler       = "program.lambda_handler"

  filename = "lambda.zip"
  role     = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      DATA_BUCKET = aws_s3_bucket.data_bucket.bucket,
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "example_lambda"

  assume_role_policy = <<EOF
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

resource "aws_iam_policy" "s3_read_policy" {
  name = "example_s3_read"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "s3:Get*",
          "s3:List*"
      ],
      "Resource": "${aws_s3_bucket.data_bucket.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_s3_read_to_lambda" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_basic_execution_to_lambda" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
