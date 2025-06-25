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

output "input-queue-url" {
  description = "URL of the input SQS queue"
  value       = aws_sqs_queue.input_queue.id
}

output "input-queue-arn" {
  description = "ARN of the input SQS queue"
  value       = aws_sqs_queue.input_queue.arn
}

output "output-queue-url" {
  description = "URL of the output SQS queue"
  value       = aws_sqs_queue.output_queue.id
}

output "output-queue-arn" {
  description = "ARN of the output SQS queue"
  value       = aws_sqs_queue.output_queue.arn
}

output "dead-letter-queue-url" {
  description = "URL of the dead-letter SQS queue"
  value       = aws_sqs_queue.dead_letter_queue.id
}

output "dead-letter-queue-arn" {
  description = "ARN of the dead-letter SQS queue"
  value       = aws_sqs_queue.dead_letter_queue.arn
}