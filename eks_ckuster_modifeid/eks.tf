module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = local.name
  cluster_version = "1.31"


  cluster_endpoint_public_access = true


  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }



  cluster_addons ={

    coredns                = {most_recent = true}
    kube-proxy             = {most_recent = true}
    vpc-cni                = {most_recent = true}

  }

     eks_managed_node_group_defaults = {
     ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]

    attach_cluster_primary_security_group = true

  }

    eks_managed_node_groups = {
    cluster = {


      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"


      min_size     = 1
      max_size     = 3
      desired_size = 2
      iam_role_arn   = aws_iam_role.eks_node_group_role.arn
    }
  }

}


resource "aws_iam_role" "eks_node_group_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach Required IAM Policies
resource "aws_iam_role_policy_attachment" "eks_worker" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_ecr" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
