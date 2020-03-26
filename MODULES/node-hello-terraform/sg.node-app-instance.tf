## APP-INSTANCE ##

resource "aws_security_group" "node-app-instance" {
  name        = "node-app-instance-sg"
  description = "Iys Api instances"
#  vpc_id      = "${aws_vpc.vpc.id}"

tags {
 key = "Name"
 value= "${var.name}-instance-sg"
}
}

#INGRESS
# SELF #
resource "aws_security_group_rule" "node-app-instance-self" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}

# 22 #
resource "aws_security_group_rule" "node-app-instance-22" {
  security_group_id        = "${aws_security_group.node-app-instance.id}"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
   source_security_group_id = "${aws_security_group.bastion.id}"
#  cidr_blocks       = ["0.0.0.0/0"]
}

# 443 #
resource "aws_security_group_rule" "node-app-instance-443-elb" {
  security_group_id        = "${aws_security_group.node-app-instance.id}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.node-app-elb.id}"
}

# 80 #
resource "aws_security_group_rule" "node-app-instance-80-elb" {
  security_group_id        = "${aws_security_group.node-app-instance.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.node-app-elb.id}"
}

resource "aws_security_group_rule" "node-app-instance-ingress-3306" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
}


#EGRESS


resource "aws_security_group_rule" "node-app-instance-egress-80" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-instance-egress-443" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "node-app-instance-egress-123" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-instance-egress-25" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 25
  to_port           = 25
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-instance-egress-all" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}
resource "aws_security_group_rule" "node-app-instance-egress-3306" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
}


# EGRESS
resource "aws_security_group_rule" "node-app-instance-egress-22" {
  security_group_id = "${aws_security_group.node-app-instance.id}"
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
source_security_group_id = "${aws_security_group.bastion.id}"
#  cidr_blocks       = ["${var.vpc_cidr_block}"]
}

