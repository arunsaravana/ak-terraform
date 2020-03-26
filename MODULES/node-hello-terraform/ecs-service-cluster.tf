resource "aws_ecs_service" "node-app" {
  name            = "node-appdb"
  cluster         = "${aws_ecs_cluster.node-app.id}"
  task_definition = "${aws_ecs_task_definition.node-app.arn}"
  desired_count   = 1
  #iam_role        = "${aws_iam_role.app.arn}"
  
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    elb_name= "${aws_elb.node-app-elb.name}"
    #target_group_arn = "${aws_lb_target_group.node.arn}"
    container_name   = "node-app"
    container_port   = 80
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b,us-east-1c]"
  }
}
