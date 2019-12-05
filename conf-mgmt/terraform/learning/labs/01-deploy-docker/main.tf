# Download the latest NGINX image
resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}
