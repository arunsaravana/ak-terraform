resource "aws_ecs_task_definition" "node-app" {
	family = "${var.name}-taskdef"
#	container_definitions = "${file("service.json")}"

container_definitions = <<DEFINITION

[
  {
    "name": "Node-app",
    "image": "node",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8000,
        "hostPort": 8000
      }
    ]
  },
  {
    "name": "webserver",
    "image": "nginx",
    "cpu": 256,
    "memory": 256,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION

}
