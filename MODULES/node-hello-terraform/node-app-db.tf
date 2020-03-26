### MySQL Server ##

resource "aws_instance" "node-app-mysql-db" {
ami 			= "ami-0756fbca465a59a30"
iam_instance_profile    = "node-app-instancerole"
instance_type           = "m5a.xlarge"
#subnet_id               =
vpc_security_group_ids  =["${aws_security_group.node-app-db.id}"]
key_name                = "${var.key_name}"
monitoring              = true
  disable_api_termination = false
private_ip = "172.31.25.217"
subnet_id = "subnet-064f434c"

  user_data               = "$(file{userdata_db_node})"

	root_block_device {
		volume_size = "30"
		volume_type = "gp2"
	}

tags = {
Name =  "${var.name}-db"
}
}

resource "aws_eip" "node-app-mysql-db" {
  vpc = true
}

resource "aws_eip_association" "eip-node-app-mysql-db-1a" {
  instance_id   = "${aws_instance.node-app-mysql-db.id}"
  allocation_id = "${aws_eip.node-app-mysql-db.id}"
}
