provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "email_validator_cluster" {
  name = "email-validator-cluster"
}

resource "aws_ecs_task_definition" "email_validator_task" {
  family                   = "email-validator-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "email-validator"
      image     = "your-dockerhub-username/email-validator:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "email_validator_service" {
  name            = "email-validator-service"
  cluster         = aws_ecs_cluster.email_validator_cluster.id
  task_definition = aws_ecs_task_definition.email_validator_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["your-subnet-id"]
    security_groups  = ["your-security-group-id"]
    assign_public_ip = true
  }
}
