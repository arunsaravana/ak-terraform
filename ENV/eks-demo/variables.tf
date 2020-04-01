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


variable "subnet-count" {
  default= 2
}
