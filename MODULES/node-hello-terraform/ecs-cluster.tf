resource "aws_ecs_cluster" "node-app" {
  name = "${var.name}-cluster"
}

