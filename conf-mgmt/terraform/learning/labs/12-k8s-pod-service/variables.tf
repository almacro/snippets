variable "app_label" {
  default = "ghost-blog"
}

variable "int_port" {
  default = "2368"
}

variable "ext_port" {
  default = "8081"
}

variable "image_name" {
  default = "ghost:alpine"
}

variable "pod_name" {
  default = "ghost-blog"
}
