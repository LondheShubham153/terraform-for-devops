locals{

  name = "my-eks-cluster"
  cidr = "10.0.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  intra_subnets       = ["10.0.51.0/24", "10.0.52.0/24"]


}

