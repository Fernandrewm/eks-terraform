terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "tls_private_key" "windows_api" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  ssh_public_keys = distinct(concat(
    [tls_private_key.windows_api.public_key_openssh],
    var.additional_ssh_public_keys
  ))

  ssh_authorized_keys = join("\n", local.ssh_public_keys)
}

resource "local_file" "windows_api_private_key" {
  filename          = var.private_key_output_path
  sensitive_content = tls_private_key.windows_api.private_key_pem
  file_permission   = "0600"
}

resource "aws_key_pair" "windows_api" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.windows_api.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-windows-api-key"
    }
  )
}

resource "aws_security_group" "windows_api" {
  name        = "${var.project_name}-windows-api-sg"
  description = "Security group for Windows API instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP access"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access from VPC"
    from_port   = 5085
    to_port     = 5085
    protocol    = "tcp"
    cidr_blocks = var.http_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-windows-api-sg"
    }
  )
}

resource "aws_instance" "windows_api" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.windows_api.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.windows_api.key_name

  user_data_replace_on_change = true
  user_data = templatefile("${path.module}/userdata.ps1.tpl", {
    authorized_keys = local.ssh_authorized_keys
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-windows-api"
    }
  )
}


