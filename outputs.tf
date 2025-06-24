# S3 output
output "parquet-data-bucket-name" {
  description = "Name of the S3 bucket for input parquet data"
  value       = aws_s3_bucket.input-parquet-data.id
}

output "input-sqs-bucket-name" {
  description = "Name of the S3 bucket for input SQS messages"
  value       = aws_s3_bucket.input-sqs-bucket.id
}

output "output-sqs-bucket-name" {
  description = "Name of the S3 bucket for output SQS messages"
  value       = aws_s3_bucket.output-sqs-bucket.id
}

output "dead-letter-sqs-bucket-name" {
  description = "Name of the S3 bucket for dead-letter SQS messages"
  value       = aws_s3_bucket.dead-letter-sqs-bucket.id

}