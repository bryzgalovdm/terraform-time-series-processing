resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-${var.environment}-esc-cluster"

}

# ECS Task Definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.project}-${var.environment}-processor"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = data.aws_cloudformation_export.ecs_task_execution_role_arn.value
  task_role_arn            = data.aws_cloudformation_export.ecs_task_role_arn.value

  container_definitions = jsonencode([
    {
      name      = "processor"
      image     = var.TestImageUri
      memory    = 2048
      cpu       = 1024
      essential = true
      environment = [
        {
          name  = "INPUT_QUEUE_URL"
          value = output.input-queue-url.value
        },
        {
          name  = "OUTPUT_QUEUE_URL"
          value = output.output-queue-url.value
        },
      ]
    },
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project}-${var.environment}-processor"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 3
  launch_type     = "FARGATE"
  iam_role        = aws_iam_role.ecs_task_execution_role.arn
  depends_on      = [aws_iam_role_policy_attachment.ecs_task_execution_role_policy_attachment]
  network_configuration {
    subnets          = data.aws_subnet_ids.private.ids
    security_groups  = [aws_security_group.foo.id]
    assign_public_ip = false
  }

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
}


resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 10 # Maximum number of tasks
  min_capacity       = 3 # Minimum number of tasks
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [aws_ecs_service.ecs_service]
}

resource "aws_appautoscaling_policy" "ecs_cpu_scaling_policy" {
  name               = "${var.project}-${var.environment}-ecs-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 10 # Target approximate number of messages in the queue

    customized_metric_specification {
      metric_name = "ApproximateNumberOfMessagesVisible"
      namespace = "AWS/SQS"
        statistic = "Average"
        dimensions {
          name = "QueueName"
          value = aws_sqs_queue.input_queue.name
        }
    }

    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}