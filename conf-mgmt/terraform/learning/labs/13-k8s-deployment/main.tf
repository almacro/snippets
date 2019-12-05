resource "kubernetes_service" "mysql_service" {
  metadata {
    name = "wordpress-mysql"
    labels {
      app = "${var.app_label}"
    }
  }
  spec {
    selector {
      app  = "${var.app_label}"
      tier = "${var.mysql_tier}"
    }
    port {
      port = "3306"
    }
    type = "NodePort"    
  }
}

resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name = "wordpress-mysql"
    labels {
      app = "${var.app_label}"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels {
        app  = "${var.app_label}"
	tier = "${var.mysql_tier}"
      }
    }
    template {
      metadata {
        labels {
	  app  = "${var.app_label}"
	  tier = "${var.mysql_tier}"
	}
      }
      spec {
        container {
	  name  = "mysql"
	  image = "mysql:5.7"
	  env {
	    name  = "MYSQL_ROOT_PASSWORD"
	    value = "${var.mysql_password}"
	  }
	  port {
	    container_port = "3306"
	    name           = "mysql"
	  }
	}
      }
    }
  }
}

resource "kubernetes_service" "wordpress_service" {
  metadata {
    name = "wordpress"
    labels {
      app = "${var.app_label}"
    }
  }
  spec {
    selector {
      app  = "${var.app_label}"
      tier = "${var.wordpress_tier}"
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 8080
    }
    type = "NodePort"
  }
}
resource "kubernetes_deployment" "wordpress_deployment" {  
  metadata {
    name = "wordpress"
  }
  spec {
    replicas = 1
    selector {
      match_labels {
        app  = "${var.app_label}"
	tier = "${var.wordpress_tier}"
      }
    }
    template {
      metadata {
        labels {
	  app  = "${var.app_label}"
	  tier = "${var.wordpress_tier}"
	}
      }
      spec {
        container {
	  name  = "wordpress"
	  image = "wordpress:${var.wordpress_version}-apache"
	  env {
	    name  = "WORDPRESS_DB_HOST"
	    value = "wordpress-mysql"
	  }
	  env {
	    name  = "WORDPRESS_DB_PASSWORD"
	    value = "${var.mysql_password}"
	  }
	  port {
	    container_port = "80"
	    name           = "wordpress"
	  }
	}
      }
    }
  }
}