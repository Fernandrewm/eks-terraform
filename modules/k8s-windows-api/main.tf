locals {
  common_labels = merge(
    {
      "app.kubernetes.io/part-of" = var.project_name
      "app.kubernetes.io/managed-by" = "terraform"
    },
    var.labels
  )
}

resource "kubernetes_service_v1" "windows_api" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    labels = merge(
      local.common_labels,
      {
        "app.kubernetes.io/name" = var.service_name
      }
    )
  }

  spec {
    port {
      name        = "http"
      port        = var.service_port
      target_port = var.service_port
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_endpoints_v1" "windows_api" {
  metadata {
    name      = kubernetes_service_v1.windows_api.metadata[0].name
    namespace = kubernetes_service_v1.windows_api.metadata[0].namespace
    labels    = kubernetes_service_v1.windows_api.metadata[0].labels
  }

  subset {
    dynamic "address" {
      for_each = var.endpoint_ips
      content {
        ip = address.value
      }
    }

    port {
      name     = "http"
      port     = var.service_port
      protocol = "TCP"
    }
  }
}

resource "kubernetes_ingress_v1" "windows_api" {
  metadata {
    name      = var.ingress_name
    namespace = var.namespace
    labels = merge(
      local.common_labels,
      {
        "app.kubernetes.io/name" = var.ingress_name
      }
    )
    annotations = var.ingress_annotations
  }

  spec {
    ingress_class_name = var.ingress_class_name

    rule {
      http {
        path {
          path      = var.path
          path_type = var.path_type

          backend {
            service {
              name = kubernetes_service_v1.windows_api.metadata[0].name

              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_endpoints_v1.windows_api]
}

