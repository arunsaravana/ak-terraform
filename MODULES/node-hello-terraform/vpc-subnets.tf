## PUBLIC
resource "aws_subnet" "public-1a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${var.region}a"
  cidr_block              = "${var.subnet_public-1a_cidr_block}"
  map_public_ip_on_launch = true

 tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-public-1a",
            "t_name", "${var.vpc_name}-public-1a",
            "t_role", "public-1c"
    )
  )}"
}

resource "aws_subnet" "public-1b" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${var.region}b"
  cidr_block              = "${var.subnet_public-1b_cidr_block}"
  map_public_ip_on_launch = false

 tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-public-1b",
            "t_name", "${var.vpc_name}-public-1b",
            "t_role", "public-1b"
    )
  )}"
}

## node-app
resource "aws_subnet" "node-app-1a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${var.region}a"
  cidr_block              = "${var.subnet_node_app-1a_cidr_block}"
  map_public_ip_on_launch = false

  tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-node-app-1a",
            "t_name", "${var.vpc_name}-node-app-1a",
            "t_role", "node-app-1a"
    )
  )}"
}

resource "aws_subnet" "node-app-1b" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${var.region}b"
  cidr_block              = "${var.subnet_node_app-1b_cidr_block}"
  map_public_ip_on_launch = false

tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-node-app-1b",
            "t_name", "${var.vpc_name}-node-app-1b",
            "t_role", "node-app-1b"
    )
  )}"
}

