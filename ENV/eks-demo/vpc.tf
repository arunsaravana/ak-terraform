 # This data source is included for ease of sample architecture deployment
 # and can be swapped out as necessary.

 resource "aws_vpc" "demo" {
   cidr_block = var.vpc-cidr
   enable_dns_hostnames = true
   enable_dns_support   = true


   tags = {
     "Name"                                      = "${var.vpc-name}"
     "kubernetes.io/cluster/${var.cluster-name}" = "shared"
   }
 }

 resource "aws_subnet" "demo" {
   count = var.subnet-count

   availability_zone = data.aws_availability_zones.available.names[count.index]
   #cidr_block        = "10.0.${count.index}.0/24"
   cidr_block        = cidrsubnet(var.vpc-cidr,var.newbits,count.index)
   vpc_id            = aws_vpc.demo.id

   tags = {
     "Name"                                      = "terraform-eks-demo-node"
     "kubernetes.io/cluster/${var.cluster-name}" = "shared"
   }
 }

 resource "aws_internet_gateway" "demo" {
   vpc_id = aws_vpc.demo.id

   tags = {
     Name = "terraform-eks-demo"
   }
 }

 resource "aws_route_table" "demo" {
   vpc_id = aws_vpc.demo.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.demo.id
   }
 }

 resource "aws_route_table_association" "demo" {
   count = var.subnet-count

   subnet_id      = aws_subnet.demo[count.index].id
   route_table_id = aws_route_table.demo.id
 }

