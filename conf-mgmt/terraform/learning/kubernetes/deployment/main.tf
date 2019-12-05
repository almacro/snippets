resource "kubernetes_service" "ghost_service" {
  metadata {
    name = "ghost-service"
  }
  spec {
    selector {
      app = "${kubernetes_deployment.ghost_deployment.spec.0.template.0.metadata.0.labels.app}"
    }
    port {
      port        = "2368"
      target_port = "2368"
      node_port   = "8080"
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "ghost_deployment" {
  metadata {
    name = "ghost-blog"
  }

  spec {
    replicas = "1"

    selector {
      match_labels {
        app = "ghost-blog"
      }
    }

    template {
      metadata {
        labels {
          app = "ghost-blog"
        }
      }

      spec {
        container {
          name  = "ghost"
          image = "ghost:alpine"
          port {
            container_port = "2368"
          }
        }
      }
    }
  }
}
