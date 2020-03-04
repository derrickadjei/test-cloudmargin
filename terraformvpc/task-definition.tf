data "aws_ecs_task_definition" "devtest" {
  task_definition = "${aws_ecs_task_definition.devtest.family}"
  depends_on = ["aws_ecs_task_definition.devtest"]
}

resource "aws_ecs_task_definition" "devtest" {
    family                = "cmtest"
    container_definitions = <<DEFINITION
[
  {
    "name": "cmtest",
    "image": "235947376681.dkr.ecr.eu-west-1.amazonaws.com/cmtest:latest",
    "cpu": 256,
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "cmtest",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
    }
  }
]
DEFINITION
}