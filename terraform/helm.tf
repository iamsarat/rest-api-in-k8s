resource "helm_release" "rest_api_in_k8s" {
  name       = "rest-api-in-k8s"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  set {
    name  = "image.repository"
    value = "chovdary/rest-api-in-k8s"
  }

  set {
    name  = "image.tag"
    value = "latest"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.port"
    value = "8080"
  }
  depends_on = [aws_eks_cluster.eks, aws_eks_node_group.eks_node_group]
}

data "kubernetes_service" "rest_api_in_k8s" {
  metadata {
    name = "rest-api-in-k8s-nginx"
  }
  depends_on = [helm_release.rest_api_in_k8s]
}

output "rest_api_in_k8s_url" {
  value = data.kubernetes_service.rest_api_in_k8s.status.0.load_balancer.0.ingress.0.hostname
}

data "http" "rest_api_in_k8s" {
  url = "http://${data.kubernetes_service.rest_api_in_k8s.status.0.load_balancer.0.ingress.0.hostname}"

  request_headers = {
    Accept = "application/json"
  }

  retry {
    attempts     = 10
    min_delay_ms = 5
    max_delay_ms = 10
  }
}

resource "null_resource" "rest_api_in_k8s" {
  provisioner "local-exec" {
    command = contains([200], data.http.rest_api_in_k8s.status_code)
  }
}
