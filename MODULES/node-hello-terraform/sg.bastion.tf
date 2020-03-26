resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "SSH and RDP for Bastion hosts"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-bastion",
            "t_name", "${var.vpc_name}-bastion",
            "t_role", "App Tier"
    )
  )}"

}
# SELF #
resource "aws_security_group_rule" "bastion-self" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}

##  BASTION RULES  ##

# INGRESS
resource "aws_security_group_rule" "bastion-ingress-22" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
 cidr_blocks       = ["0.0.0.0/0"]
}

# EGRESS
resource "aws_security_group_rule" "bastion-egress-22" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "bastion-egress-443" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress-123" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}

