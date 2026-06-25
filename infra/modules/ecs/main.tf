#ECS Cluster
resource "aws_ecs_cluster" "ecs-threatapp" {
  name = "ecs-threatapp"
}

resource "aws_ecs_cluster_capacity_providers" "ecs-threatapp-capacity-providers" {
  cluster_name = aws_ecs_cluster.ecs-threatapp.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

#IAM
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

#ECS Task Definition and Service
resource "aws_ecs_task_definition" "ecs-threatapp-task" {
  family                   = "ecs-threatapp-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "threatapp-container"
      image     = "${var.ecr_repository_url}:${var.image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ecs-threatapp-service" {
  name            = "ecs-threatapp-service"
  cluster         = aws_ecs_cluster.ecs-threatapp.id
  task_definition = aws_ecs_task_definition.ecs-threatapp-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [var.public_subnet_1_id, var.public_subnet_2_id]
    security_groups = [aws_security_group.ecs-sg.id]
    assign_public_ip = true
  }

  depends_on = [var.https_listener_arn]

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "threatapp-container"
    container_port   = 8080
  }
}

#ECS Security Group
resource "aws_security_group" "ecs-sg" {
  name        = "ecs-sg"
  description = "Security group for ECS service"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}