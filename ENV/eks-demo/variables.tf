variable "region" {
 default= "us-east-1"
}
variable "cluster-name" {
  default = "eks-demo"
  type    = string
}

variable "nodegroup" {
  default= "demo-ng"
}

variable "vpc-name" {
  default= "eks-demo"
}

variable "vpc-cidr" {
  default="10.0.0.0/16"
}

variable "newbits" {
  default= "8"
}

variable "subnet-count" {
  default= 2
}

variable "ng-instacetypes" {
#	type = "list"
  default= ["t2.micro"]
}

variable "key" {
  default= "sample"
}
