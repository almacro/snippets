output "ip" {
  value = "${docker_container.ghost_container.ip_address}"
}

output "container_name" {
  value = "${docker_container.ghost_container.name}"
}
