resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${aws_eks_cluster.eks.name}-ng"
  node_role_arn   = aws_iam_role.eks_node_iam_role.arn
  subnet_ids      = aws_subnet.eks_vpc_private_subnet[*].id

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  capacity_type  = "SPOT"
  disk_size      = 20
  instance_types = ["t2.micro"]

  tags = merge(
    var.tags
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_iam_policy,
    aws_iam_role_policy_attachment.eks_node_iam_cni_policy,
    aws_iam_role_policy_attachment.eks_node_iam_ecr_policy
  ]
}

resource "aws_iam_role" "eks_node_iam_role" {
  name = "eks-node-group-demo-cluster-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_node_iam_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_iam_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_iam_ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_iam_role.name
}
