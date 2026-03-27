# Zip the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/function"
  output_path = "${path.module}/lambda/function.zip"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach basic Lambda execution policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "my_function" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "my-terraform-lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = {
    Name        = "MyTerraformLambda"
    Environment = var.environment
  }
}

# Lambda Function URL — gives Lambda a public URL
resource "aws_lambda_function_url" "my_function_url" {
  function_name      = aws_lambda_function.my_function.function_name
  authorization_type = "NONE"
}

# Output the Lambda URL
output "lambda_url" {
  value = aws_lambda_function_url.my_function_url.function_url
}
