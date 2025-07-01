resource "aws_sqs_queue" "dead_letter_queue" {
  name                       = "${var.project}-${var.environment}-dead-letter-queue"
  message_retention_seconds  = 604800 # 7 days
  receive_wait_time_seconds  = 20     # Long polling
  visibility_timeout_seconds = 900    # 15 minutes

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "input_queue" {
  name                       = "${var.project}-${var.environment}-input-queue"
  message_retention_seconds  = 86400 # 1 day
  receive_wait_time_seconds  = 20    # Long polling
  visibility_timeout_seconds = 900   # 15 minutes
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 3 # After 3 failed attempts, messages will be sent to the dead-letter queue
  })

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "output_queue" {
  name                       = "${var.project}-${var.environment}-output-queue"
  message_retention_seconds  = 86400 # 1 day
  receive_wait_time_seconds  = 20    # Long polling
  visibility_timeout_seconds = 900   # 15 minutes

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue_policy" "dead_letter_queue_policy" {
  queue_url = aws_sqs_queue.dead_letter_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.dead_letter_queue.arn
        Condition = {
          StringEquals = {
            "aws:SourceArn" = aws_sqs_queue.input_queue.arn
          }
        }
      }
    ]
  })
}