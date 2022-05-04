locals {
  image              = "var.repository_url:var.image_tag"
  execution_role_arn = aws_iam_role.altimonia_api_task_execution_role.arn
}

resource "aws_cloudwatch_log_group" "altimonia_api" {
  name = "/ecs/altimonia-api"
}

resource "aws_ecs_cluster" "altimonia-ecs-cluster" {
  name = "altimonia-ecs-cluster"
}

resource "aws_ecs_service" "altimonia-ecs-service-two" {
  name            = "altimonia-app"
  cluster         = aws_ecs_cluster.altimonia-ecs-cluster.id
  task_definition = aws_ecs_task_definition.altimonia-ecs-task-definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.egress_all.id,
      aws_security_group.ingress_api.id,
    ]
    subnets = [
      aws_subnet.altimonia_vpc_private_subnet_one.id,
      aws_subnet.altimonia_vpc_private_subnet_two.id,
    ]
  }
  desired_count = 2
}

resource "aws_ecs_task_definition" "altimonia-ecs-task-definition" {
  family                   = "altimonia-ecs-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = local.execution_role_arn
  #             "image" : "569387170030.dkr.ecr.us-east-1.amazonaws.com/altimonia-ecr/mysql-flask:latest",
  container_definitions = <<DEFINE
    [
      {
        "name" : "altimonia-container",
        "image" : "${aws_ecr_repository.altimonia.repository_url}:${var.image_tag}",
        "memory" : 1024,
        "cpu" : 512,
        "essential" : true,
        "entryPoint" : ["/"],
        "portMappings" : [
          {
            "containerPort" : 5000,
            "hostPort" : 5000
          }
        ],
        "environment" : [
          {
            "name" : "host",
            "value" : "${aws_db_instance.altimonia_database_instance.address}"
          }
        ],
        "logConfiguration" : {
          "logDriver" : "awslogs",
          "options" : {
            "awslogs-region" : "us-east-1",
            "awslogs-group" : "/ecs/altimonia-api",
            "awslogs-stream-prefix" : "ecs"
          }
        }
      }
    ]
DEFINE
}
