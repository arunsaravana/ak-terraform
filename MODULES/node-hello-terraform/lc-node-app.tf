resource "aws_launch_configuration" "node-app-lc-app" {
	name_prefix = "node-app-lc-app-use-"
## AMI from node-app ##
	image_id    = "ami-00eb20669e0990cb4"

	instance_type               = "m5.xlarge"
	iam_instance_profile        = "node-app-instancerole"
	key_name                    = "${var.key_name}"
	security_groups             = ["${aws_security_group.node-app-instance.id}"]
	enable_monitoring           = true
	user_data                   = "$(file{userdata_node_app})"

  # Disk for additional docker-pool
  root_block_device {
    volume_size = "30"
volume_type = "gp2"
  }

depends_on = ["aws_sns_topic.node-app-sns"]

  lifecycle {
    create_before_destroy = true
  }
}

