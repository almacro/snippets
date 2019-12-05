# Download the image
resource "docker_image" "image_id" {
  name = "${var.image_name}"
}
