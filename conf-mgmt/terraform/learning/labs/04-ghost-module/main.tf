module "ghost" {
  source         = "./ghost"
  image_name     = "${var.image_name}"
  container_name = "${var.container_name}"
  ext_port       = "${var.ext_port}"
}
