resource "aws_cloudwatch_metric_alarm" "memory-high" {
    alarm_name = "cmtest-high-instances"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_actions = [
        "${aws_autoscaling_policy.instance-scale-up.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.ecs-autoscaling-group.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "memory-low" {
    alarm_name = "cmtest-low-instances"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "40"
    alarm_actions = [
        "${aws_autoscaling_policy.instance-scale-down.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.ecs-autoscaling-group.name}"
    }
}