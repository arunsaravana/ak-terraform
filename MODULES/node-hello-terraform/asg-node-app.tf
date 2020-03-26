resource "aws_autoscaling_group" "node-app-asg" {
  name                 = "node-app-asg-use1"
  vpc_zone_identifier  = ["${aws_subnet.node-app-1a.id}", "${aws_subnet.node-app-1b.id}"]
  launch_configuration = "${aws_launch_configuration.node-app-lc-app.id}"
  max_size             = 3
  min_size             = 1
  desired_capacity     = 1
  termination_policies      = ["OldestInstance"]
  health_check_grace_period = 300
  health_check_type         = "EC2"
  load_balancers            = ["${aws_elb.node-app-elb.id}"]
  enabled_metrics           = ["GroupStandbyInstances", "GroupTotalInstances", "GroupPendingInstances", "GroupTerminatingInstances", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupMinSize", "GroupMaxSize"]

  lifecycle {
    create_before_destroy = true
  }

tag {
 key = "Name"
 value = "${var.name}-app"
 propagate_at_launch = true
 }

tag {
 key = "Terraform"
 value = "Yes"
 propagate_at_launch = true
 }
}

resource "aws_autoscaling_notification" "node-app" {
  group_names   = ["${aws_autoscaling_group.node-app-asg.id}"]
  notifications = ["autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_LAUNCH_ERROR", "autoscaling:EC2_INSTANCE_TERMINATE", "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"]
  topic_arn     = "${aws_sns_topic.node-app-sns.id}"
}

