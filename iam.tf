resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project}-${var.environment}-ECS-TaskExecution-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

}

resource "aws_iam_policy" "esc_task_execution_policy" {
  name        = "${var.project}-${var.environment}-ECS-SQS-Access"
  description = "IAM policy for ECS task to access SQS queues for ${var.project}-${var.environment}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
        ]
        Resource = output.input-queue-arn.value
      },
      {
        Effect = "Allow"
        Action = "sqs:SendMessage"
        Resource = output.output-queue-arn.value
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "ecs_task_role_sqs_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.esc_task_execution_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}