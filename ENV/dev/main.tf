module "infra-code" {
 source="../../MODULES/node-hello-terraform/"


	name				= "${var.name}"
	region				= "${var.region}"
	key_name			= "${var.key_name}"
	vpc_cidr_block			= "${var.vpc_cidr_block}"
	vpc_name			= "${var.vpc_name}"
	subnet_node_app-1a_cidr_block	= "${var.subnet_node_app-1a_cidr_block}"
	subnet_node_app-1b_cidr_block	= "${var.subnet_node_app-1b_cidr_block}"
	subnet_public-1a_cidr_block	= "${var.subnet_public-1a_cidr_block}"
	subnet_public-1b_cidr_block	= "${var.subnet_public-1b_cidr_block}"
	#access_key			= "${var.access_key}"
	#secret_key			= "${var.secret_key}"

}
