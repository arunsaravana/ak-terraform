### ROUTE TABLE CREATION ###

/*

Change private names to reflect the AZs they are going in.

*/

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-public",
            "t_name", "${var.vpc_name}-public",
            "t_role", "alf dev public route"
    )
  )}"
}

resource "aws_route_table" "private-1a" {
  vpc_id = "${aws_vpc.vpc.id}"

 tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-private-1a",
            "t_name", "${var.vpc_name}-private-1a",
            "t_role", "node-app-private-1a"
    )
  )}"
}


resource "aws_route_table" "private-1b" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-private-1b",
            "t_name", "${var.vpc_name}-private-1b",
            "t_role", "node-app-private-1b"
    )
  )}"
}


###  GATEWAY ROUTES  ###

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

resource "aws_route" "private-1a" {
  route_table_id         = "${aws_route_table.private-1a.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.ngw-1a.id}"
}

resource "aws_route" "private-1b" {
  route_table_id         = "${aws_route_table.private-1b.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.ngw-1b.id}"
}

## node-app
resource "aws_route_table_association" "node-app-1a" {
  subnet_id      = "${aws_subnet.node-app-1a.id}"
  route_table_id = "${aws_route_table.private-1a.id}"
}

resource "aws_route_table_association" "node-app-1b" {
  subnet_id      = "${aws_subnet.node-app-1b.id}"
  route_table_id = "${aws_route_table.private-1b.id}"
}

## PUBLIC
resource "aws_route_table_association" "public-1a" {
  subnet_id      = "${aws_subnet.public-1a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public-1b" {
  subnet_id      = "${aws_subnet.public-1b.id}"
  route_table_id = "${aws_route_table.public.id}"
}

