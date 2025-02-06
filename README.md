# Terraform EKS Cluster

This projects contains Terraform code to create a fully functional Amazon EKS (Elastic Kubernetes Service) cluster with all the necessary networking infrastructure on AWS.

## Infrastructure Overview

### VPC and Networking
- Creates a VPC with CIDR block 10.0.0.0/16
- Create 4 subnets across 2 avaliability zones in us-west-2:
  - 2 public subnets (10.0.1.0/24, 10.0.2.0/24)
  - 2 private subnets (10.0.3.0/24, 10.0.4.0/24)
- Sets up Internet Gateway for public subnets
- Creates a NAT Gateway in the first public subnet for private subnet internet access.
- Configures route tables:
  - Public route table: Routes traffic through Internet Gateway
  - Private route table: Routes traffic through NAT Gateway

### EKS Cluster
- Create an EKS Cluster version 1.32
- Deploys the cluster control plane in the private subnets
- Enables both private and public endpoint access
- Configures necessary IAM roles and policies for the cluster
- Sets up OIDC provider for service account integration

### Node Group
- Creates a managed node group with:
  - ARM-based instances (t4g.medium)
  - Auto-scaling configuration (min: 2, desired: 2, max: 3 nodes)
  - 20GB disk size per node
  - Deployed in private subnets
- Configures requried IAM roles and policies for nodes including:
  - EKS worker node policy
  - CNI policy
  - EC2 Container Registry read access
  - SSM access
  - S3 access policy

### Add-ons
- Installs AWS Load Balancer Controller using Helm
- Installs Nginx Ingress Controller using Helm
- Sets up IAM roles and policies for the Load Balancer Controller
- Configures OIDC-based authentication for service accounts
- Configures ALB Ingress for Nginx Controller access

## Module Structure
- `vpc`: Handles VPC creation and basic networking
- `subnets`: Manages public and private subnet creation
- `gateways`: Configures Internet Gateway, NAT Gateway and Route Tables
- `eks`: Manaes the EKS cluster and its IAM roles
- `eks-node-group`: Handles the EKS worker nodes configuration
- `eks-add-ons`: Manages cluster add-ons and their IAM configurations

## Ingress Architecture
- AWS Application Load Balancer (ALB) as the external entry point
- Nginx Ingress Controller running with ClusterIP service type
- Two-tier ingress setup:
  - ALB Ingress -> Nginx Ingress Controller
  - Nginx Ingress -> Backend Services
- Sample applications provided to test ingress routing:
  - Blue/Green application (/blue and /green paths)
  - Orange/Purple application (/orange and /purple paths)

## Security Features
- Private subnets for worker nodes
- Security group configurations for cluster components
- IAM roles with least privileges access
- OIDC integration for service accounts
- Private endpoint access enabled

## Tagging Strategy
All resources are tagged with:
- Project name
- Environment (test)
- Terraform managed indicator

## What's next?
- [After creating the EKS cluster](docs/01-after-creating-eks.md)
- [Deploy sample applications to test Ingress routing](apps/README.md)

## Importante Notes
- ***This is a test project to learn how to create a EKS cluster using Terraform, it is not intended to be used as a production cluster***
- The cluster uses ARM-based instances for cost optimization
- NAT Gateway is deployed in the first public subnet.
- Load Balancer Controller is installed for mananing AWS ALB/NLB.
- Nginx Ingress Controller is deployed with ClusterIP service type.
- ALB Ingress is configured to route traffic to Nginx Ingress Controller.
- All necessary networking componentes are properly configured for cluster communication.


## References
- [Install AWS Load Balancer Controller with Helm](https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html)
- [A deeper look at ingress sharing and target group binding in AWS Load Balancer Controller](https://aws.amazon.com/blogs/containers/a-deeper-look-at-ingress-sharing-and-target-group-binding-in-aws-load-balancer-controller/)
- [Nginx Ingress Controller Installation Guide](https://kubernetes.github.io/ingress-nginx/deploy/)
