resource "kubernetes_service" "ghost_service" {
  metadata {
    name = "ghost-service"
  }
  spec {
    selector {
      app = "${kubernetes_pod.ghost_alpine.metadata.0.labels.app}"
    }
    port {
      port = "2368"
      target_port = "2368"
      node_port = "8081"
    }
    type = "NodePort"
  }
}

resource "kubernetes_pod" "ghost_alpine" {
  metadata {
    name = "ghost-alpine"
    labels {
      app = "ghost-blog"
    }
  }

  spec {
    container {
      image = "ghost:alpine"
      name  = "ghost-alpine"
      port  {
        container_port = "2368"
      }
    }
  }
}
