resource "aws_alb" "ecs-load-balancer" {
  name            = "ecs-load-balancer"
  security_groups = ["${aws_security_group.test_public_sg.id}"]
  subnets         = ["${aws_subnet.testPubSN.0.id}","${aws_subnet.testPubSN.1.id}"]

  tags {
    Name = "ecs-load-balancer"
  }
}

resource "aws_alb_target_group" "ecs-target-group" {
  name     = "ecs-target-group"
  port     = "8080"
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.testVPC.id}"

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "6"
    interval            = "30"
    matcher             = "200,301,302"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags {
    Name = "ecs-target-group"
  }
}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_film_rating_app" {
  autoscaling_group_name = "ecs-autoscaling-group"
  alb_target_group_arn   = "${aws_alb_target_group.ecs-target-group.arn}"
  depends_on = [ "aws_autoscaling_group.ecs-autoscaling-group" ]
}