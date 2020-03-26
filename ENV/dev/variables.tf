
#variable "access_key" {}

#variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "node-app-new-use1"
}

variable "vpc_cidr_block" {
 default = "10.0.0.0/20"
}
variable "name" {
  default = "node-app"
}
variable "vpc_name" {
 default = "node-app"
}

variable "subnet_node_app-1a_cidr_block" {
  default = "${cidrsubnet(${var.vpc_cidr_block} ,4 ,0)}"
}

variable "subnet_node_app-1b_cidr_block" {
  default = "${cidrsubnet(${var.vpc_cidr_block} ,4 ,1)}"
  #default = "10.0.1.0/24"
}

variable "subnet_public-1a_cidr_block" {
	default = "${cidrsubnet(${var.vpc_cidr_block} ,4 ,2)}"
#  default = "10.0.2.0/24"
}

variable "subnet_public-1b_cidr_block" {
	default = "${cidrsubnet(${var.vpc_cidr_block} ,4 ,3)}"
#  default = "10.0.3.0/24"
}

locals {
  common_tags = "${map(
 "Terraform", "Yes",
 )}"
}


