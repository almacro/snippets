resource "docker_network" "public_overlay_network" {
  name   = "public_network"
  driver = "overlay"
}

resource "docker_network" "private_overlay_network" {
  name     = "mysql_internal"
  driver   = "overlay"
  internal = true
}
