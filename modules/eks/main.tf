resource "aws_eks_cluster" "main" {
  name = "${var.project_name}-cluster"
  role_arn = aws_iam_role.cluster_role.arn
  version = "1.32"

  vpc_config {
    subnet_ids = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access = true
    security_group_ids = [aws_security_group.cluster.id]
  }

  enabled_cluster_log_types = []

  depends_on = [ 
    aws_iam_role_policy_attachment.cluster_policies
   ]

   tags = var.tags
}

# Security group for the cluster
resource "aws_security_group" "cluster" {
  name = "${var.project_name}-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id = var.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster-sg"
    }
  )
}