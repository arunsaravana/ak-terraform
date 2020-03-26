##  APP-ELB  ##

resource "aws_security_group" "node-app-elb" {
  name        = "node-app-elb"
  description = "ELB rules for node-app "
  vpc_id      = "${aws_vpc.vpc.id}"

tags {
 key = "Name"
 value = "${var.name}-elb-sg"
}

}
##  APP-ELB RULES  ##

# 443 #
resource "aws_security_group_rule" "node-app-elb-443" {
  security_group_id = "${aws_security_group.node-app-elb.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# 80 #
resource "aws_security_group_rule" "node-app-elb-80" {
  security_group_id = "${aws_security_group.node-app-elb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
# EGRESS #

resource "aws_security_group_rule" "node-app-elb-egress-80" {
  security_group_id        = "${aws_security_group.node-app-elb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.node-app-instance.id}"
}

resource "aws_security_group_rule" "node-app-elb-egress-443" {
  security_group_id        = "${aws_security_group.node-app-elb.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.node-app-instance.id}"
}

