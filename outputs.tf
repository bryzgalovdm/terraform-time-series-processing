#------------------- S3 output
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
#------------------- SQS output
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

#------------------- ECS output
output "ecs-cluster-name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.name

}

output "ecs-service-name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.ecs_service.name

}

output "ecs-task-definition-arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.ecs_task_definition.arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
  
}

#------------------- Network output
output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "A list of IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "A list of IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "The ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table."
  value       = aws_route_table.private.id
}

output "ecs_security_group_id" {
  description = "The ID of the ECS security group."
  value       = aws_security_group.ecs.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.main.id
}