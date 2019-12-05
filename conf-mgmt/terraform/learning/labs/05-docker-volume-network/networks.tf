resource "docker_network" "private_bridge_network" {
  name     = "${var.mysql_network_name}"
  driver   = "bridge"
  internal = true
}
