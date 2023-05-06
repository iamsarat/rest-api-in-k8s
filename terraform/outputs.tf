output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint_url" {
  value = aws_eks_cluster.eks.endpoint
}

output "rest_api_in_k8s_url" {
  value = data.kubernetes_service.rest_api_in_k8s.status.0.load_balancer.0.ingress.0.hostname
}
