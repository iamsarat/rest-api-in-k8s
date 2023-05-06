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

resource "null_resource" "rest_api_in_k8s" {
  provisioner "local-exec" {
    command = contains([200], data.http.rest_api_in_k8s.status_code)
  }
}
