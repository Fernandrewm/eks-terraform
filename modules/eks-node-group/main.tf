resource "aws_eks_node_group" "main" {
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