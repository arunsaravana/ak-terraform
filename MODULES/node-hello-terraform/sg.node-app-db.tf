
resource "aws_security_group" "node-app-db" {
 name        = "node-app-db-sg"
  description = "Iys Api DB"

tags {
 key = "Name"
 value= "${var.name}-db-sg"
}

}

#INGRESS
# SELF #
resource "aws_security_group_rule" "node-app-db-self" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}

# 22 #
resource "aws_security_group_rule" "node-app-db-22" {
  security_group_id        = "${aws_security_group.node-app-db.id}"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
   source_security_group_id = "${aws_security_group.node-app-instance.id}"
#  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "node-app-db-443" {
  security_group_id        = "${aws_security_group.node-app-db.id}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-db-80" {
  security_group_id        = "${aws_security_group.node-app-db.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-instance-db-3306" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
}

#EGRESS


resource "aws_security_group_rule" "node-app-db-egress-80" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-db-egress-443" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "node-app-db-egress-123" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-db-egress-25" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "egress"
  from_port         = 25
  to_port           = 25
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-app-db-egress-all" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}

resource "aws_security_group_rule" "node-app-db-egress-3306" {
  security_group_id = "${aws_security_group.node-app-db.id}"
  type              = "egress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr_block}"]
}

