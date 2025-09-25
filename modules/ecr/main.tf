resource "aws_ecr_repository" "frontend_dashboard" {
  name                 = "frontend-dashboard"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-frontend-dashboard"
    }
  )
}

resource "aws_ecr_repository" "backend_ventas" {
  name                 = "backend-ventas"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-backend-ventas"
    }
  )
}

