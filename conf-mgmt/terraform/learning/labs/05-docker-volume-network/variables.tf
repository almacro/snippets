variable "container_name" {
  description = "The MySQL container name."
  default     = "mysql"
}

variable "mysql_root_password" {
  description = "The MySQL root password."
  default     = "P4sSw0rd0!"
}

variable "mysql_network_name" {
  description = "The MySQL's network'."
  default     = "mysql_internal_network"
}

variable "mysql_volume_name" {
  description = "The MySQL's volume'."
  default     = "mysql_data"
}
