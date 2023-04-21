provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "yogi-tf"
    key    = "terraform-backend/eks-test.tf"
    region = "us-east-1"
  }
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
   endpoint_private_access = false
  endpoint_public_access  = true
    subnet_ids = ["10.0.4.0/24", "10.0.5.0/24"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster,
  ]
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

data "aws_eks_cluster_auth" "my_cluster" {
  name = aws_eks_cluster.my_cluster.name
}

output "kubeconfig" {
  value = data.aws_eks_cluster_auth.my_cluster.kubeconfig
}
