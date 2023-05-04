output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint_url" {
  value = aws_eks_cluster.eks.endpoint
}
