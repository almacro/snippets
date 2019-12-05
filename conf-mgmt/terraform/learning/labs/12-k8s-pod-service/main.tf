resource "kubernetes_service" "ghost_service" {
  metadata {
    name = "ghost-service"
  }
  spec {
    selector {
      app = "${var.app_label}"
    }
    port {
      port        = "${var.int_port}"
      target_port = "${var.int_port}"
      node_port   = "${var.ext_port}"
    }
    type = "NodePort"
  }
}

resource "kubernetes_pod" "ghost_blog" {
  metadata {
    name = "ghost-pod"
    labels {
      app = "${var.app_label}"
    }
  }
  spec {
    container {
      image = "${var.image_name}"
      name  = "${var.pod_name}"
      port {
        container_port = "${var.int_port}"
      }
    }
  }
}