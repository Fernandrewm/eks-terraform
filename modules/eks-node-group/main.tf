resource "aws_eks_node_group" "arm64" {
  cluster_name = var.cluster_name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn = var.node_role_arn
  subnet_ids = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    min_size = 2
    max_size = 3
  }

  ami_type = "AL2_ARM_64" # Amazon Linux 2 ARM
  instance_types = ["t4g.medium"]
  disk_size = 20

  remote_access {}

  tags = var.tags

  depends_on = [
    var.cluster_depends_on
  ]
}

resource "aws_eks_node_group" "amd64" {
  cluster_name = var.cluster_name
  node_group_name = "${var.project_name}-amd64-node-group"
  node_role_arn = var.node_role_arn
  subnet_ids = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    min_size = 2
    max_size = 3
  }

  ami_type = "AL2_x86_64" # Amazon Linux 2 x86_64
  instance_types = ["t3.medium"]
  disk_size = 20

  remote_access {}

  tags = merge(
    var.tags,
    {
      "kubernetes.io/arch" = "amd64"
    }
  )

  depends_on = [
    var.cluster_depends_on
  ]
  
}