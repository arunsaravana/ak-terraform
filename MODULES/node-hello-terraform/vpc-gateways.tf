### INTERNET GATEWAY ###

/*

Modify tags

*/

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

 tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-ig",
            "t_name", "${var.vpc_name}-ig",
            "t_role", "Internet Gateway"
    )
  )}"
}

### ELASTIC IP'S FOR NAT GATEWAYS ###

resource "aws_eip" "nat-1a" {
  vpc = true
}

resource "aws_eip" "nat-1b" {
  vpc = true
}


### NAT GATEWAYS ###

resource "aws_nat_gateway" "ngw-1a" {
  allocation_id = "${aws_eip.nat-1a.id}"
  subnet_id     = "${aws_subnet.public-1a.id}"
  depends_on    = ["aws_internet_gateway.ig"]

tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-nat-1a",
            "t_name", "${var.vpc_name}-nat-1a",
            "t_role", "NAT Gateway"
    )
  )}"
}

resource "aws_nat_gateway" "ngw-1b" {
  allocation_id = "${aws_eip.nat-1b.id}"
  subnet_id     = "${aws_subnet.public-1b.id}"
  depends_on    = ["aws_internet_gateway.ig"]

tags = "${merge(
    local.common_tags,
    map(
            "Name", "${var.vpc_name}-nat-1b",
            "t_name", "${var.vpc_name}-nat-1b",
            "t_role", "NAT Gateway"
    )
  )}"

}

