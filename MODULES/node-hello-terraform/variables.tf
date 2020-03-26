
variable "region" {}
variable "key_name" {}
variable "vpc_cidr_block" {}
variable "name" {}
variable "vpc_name" {}
variable "subnet_node_app-1a_cidr_block" {}
variable "subnet_node_app-1b_cidr_block" {}
variable "subnet_public-1a_cidr_block" {}
variable "subnet_public-1b_cidr_block" {}
#variable "secret_key" {}
#variable "access_key" {}

locals {
  common_tags = "${map(
 "Terraform", "Yes",
 )}"
}

