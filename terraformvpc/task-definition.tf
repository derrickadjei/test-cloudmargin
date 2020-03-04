data "aws_ecs_task_definition" "devtest" {
  task_definition = "${aws_ecs_task_definition.devtest.family}"
}

resource "aws_ecs_task_definition" "devtest" {
    family                = "hello_world"

}