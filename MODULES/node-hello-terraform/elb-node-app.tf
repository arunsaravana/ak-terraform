resource "aws_s3_bucket" "node-app-elb-bucket" {
  bucket = "elb-access-log.node-app-us-east-1"
#  policy = "${file("elb-app-node-app-policy")}"

}

resource "aws_elb" "node-app-elb" {
  name            = "node-app-elb"
  subnets         = ["${aws_subnet.node-app-1a.id}", "${aws_subnet.node-app-1b.id}"]
  security_groups = ["${aws_security_group.node-app-elb.id}"]

  cross_zone_load_balancing   = true
  idle_timeout                = 3600
  connection_draining         = true
  connection_draining_timeout = 300

#    listener {
#    instance_port      = 443
#    instance_protocol  = "https"
#    lb_port            = 443
#    lb_protocol        = "https"
#    ssl_certificate_id = "<AWS_ACM>"
#  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 30
    #target              = "https:443/healthcheck/"
    target              = "TCP:8000"
    timeout             = 5
    unhealthy_threshold = 5
  }
}

###  STICKINESS Policies

###  Please note that Stickiness Policies and SSL Negotiation Policies are both published together at the end of this file

resource "aws_load_balancer_policy" "443-stickiness-policy-node-app-elb" {
  load_balancer_name = "${aws_elb.node-app-elb.id}"
  policy_name        = "443-stickiness-policy-node-app-elb"
  policy_type_name   = "AppCookieStickinessPolicyType"

  policy_attribute {
    name  = "CookieName"
    value = "JSESSIONIDARUN"
  }
}

###  SSL Negotiation Policies

###  Please note that Stickiness Policies and SSL Negotiation Policies are both published together at the end of this file

resource "aws_load_balancer_policy" "443-ssl-policy-node-app-elb" {
  load_balancer_name = "${aws_elb.node-app-elb.id}"
  policy_name        = "443-ssl-policy-node-app-elb"
  policy_type_name   = "SSLNegotiationPolicyType"


  policy_attribute {
    name  = "Protocol-TLSv1.2"
    value = "true"
  }

  policy_attribute {
    name  = "Server-Defined-Cipher-Order"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-ECDSA-AES128-GCM-SHA256"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-RSA-AES128-GCM-SHA256"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-ECDSA-AES128-SHA256"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-RSA-AES128-SHA256"
    value = "true"
  }



  policy_attribute {
    name  = "ECDHE-ECDSA-AES256-GCM-SHA384"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-RSA-AES256-GCM-SHA384"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-ECDSA-AES256-SHA384"
    value = "true"
  }

  policy_attribute {
    name  = "ECDHE-RSA-AES256-SHA384"
    value = "true"
  }


  policy_attribute {
    name  = "AES128-GCM-SHA256"
    value = "true"
  }

  policy_attribute {
    name  = "AES128-SHA256"
    value = "true"
  }


  policy_attribute {
    name  = "AES256-GCM-SHA384"
    value = "true"
  }

  policy_attribute {
    name  = "AES256-SHA256"
    value = "true"
  }

}
/*
###  PUBLISH POLICIES TO Listeners

resource "aws_load_balancer_listener_policy" "443-lb-policies-node-app-elb" {
  load_balancer_name = "${aws_elb.node-app-elb.id}"
  load_balancer_port = 443

  policy_names = [
    "${aws_load_balancer_policy.443-ssl-policy-node-app-elb.policy_name}",
    "${aws_load_balancer_policy.443-stickiness-policy-node-app-elb.policy_name}",
  ]
}
*/
