###  BASTION INSTANCES  ###

resource "aws_instance" "bastion-1a" {
  ami                     = "ami-00eb20669e0990cb4"
  iam_instance_profile    = "ssmInstanceRole"
  instance_type           = "t2.micro"
  subnet_id               = "${aws_subnet.public-1a.id}"
  vpc_security_group_ids  = ["${aws_security_group.bastion.id}"]
  key_name                = "${var.key_name}"
  monitoring              = true
  disable_api_termination = false
  #user_data               = "${data.template_file.bastion-userdata-template.rendered}"

   tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-bastion-1a",
            "t_name", "${var.vpc_name}-bastion-1a",
            "t_role", "Bastion Host"
    )
  )}"

}

### ELASTIC IP'S FOR BASTIONS  ###

resource "aws_eip" "bastion-1a" {
  vpc = true
}

###  ELASTIC IP ASSOCIATIONS  ###

resource "aws_eip_association" "eip-bastion-1a" {
  instance_id   = "${aws_instance.bastion-1a.id}"
  allocation_id = "${aws_eip.bastion-1a.id}"
}

