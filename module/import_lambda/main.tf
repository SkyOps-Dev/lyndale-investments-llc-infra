resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/${var.prefix.environment}/${var.prefix.name}/${var.import_lambda.name}"
  retention_in_days = 7

  tags = {
    Name        = "${var.prefix.environment}-${var.prefix.name}-${var.import_lambda.name}"
    Environment = var.prefix.environment
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/${var.import_lambda.name}.py"
  output_path = "${path.module}/${var.import_lambda.name}.zip"
}


resource "aws_lambda_function" "import_function" {
  function_name = "${var.prefix.environment}-${var.prefix.name}-${var.import_lambda.name}"
  role          = "arn:aws:iam::471112801225:role/lambda_execution_role"
  handler       = "${var.import_lambda.name}.lambda_handler"
  runtime       = "python3.8" 
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256


  depends_on = [
    aws_cloudwatch_log_group.this,
  ]
}



