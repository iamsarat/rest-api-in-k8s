data "aws_region" "current" {}

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

data "kubernetes_service" "rest_api_in_k8s" {
  metadata {
    name = "rest-api-in-k8s-nginx"
  }
  depends_on = [helm_release.rest_api_in_k8s]
}

data "http" "rest_api_in_k8s" {
  url = "http://${data.kubernetes_service.rest_api_in_k8s.status.0.load_balancer.0.ingress.0.hostname}"

  request_headers = {
    Accept = "application/json"
  }

  retry {
    attempts     = 50
    min_delay_ms = 20
    max_delay_ms = 30
  }
}
