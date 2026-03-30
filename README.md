# Terraform for DevOps — Hands-On Repo

This repository is your one-stop solution for learning Terraform as a DevOps Engineer. It covers basics through advanced features with real AWS infrastructure.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0 (recommended: 1.14.x)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured with valid credentials
- An AWS account (Free Tier works for most examples)

## Versions Used

| Tool | Version |
|------|---------|
| Terraform | >= 1.5.0 |
| AWS Provider | ~> 6.0 |
| EKS Module | ~> 21.0 |
| VPC Module | ~> 5.0 |

## Repository Structure

```
terraform-for-devops/
├── terraform.tf          # Provider config & version constraints
├── variables.tf          # Input variables with validation
├── ec2.tf                # EC2 instance, security group, key pair
├── s3.tf                 # S3 bucket with versioning & encryption
├── dynamodb.tf           # DynamoDB table
├── outputs.tf            # Output values
├── script.sh             # EC2 user_data bootstrap script
├── terra-key.pub         # SSH public key
│
├── eks/                  # EKS Cluster (v21.x module)
│   ├── provider.tf       # Provider + locals
│   ├── vpc.tf            # VPC module for EKS networking
│   └── eks.tf            # EKS cluster with managed node groups
│
├── aws_module_project/   # Reusable Modules example
│   ├── terraform.tf      # Provider version constraints
│   ├── providers.tf      # AWS provider region
│   ├── main.tf           # Module composition (dev, stg, prd)
│   └── my_app_infra_module/  # The reusable module
│       ├── variables.tf  # Module inputs with validation
│       ├── my_server.tf  # EC2 instances (count)
│       ├── my_bucket.tf  # S3 bucket
│       ├── my_table.tf   # DynamoDB table
│       └── my_outputs.tf # Module outputs
│
└── examples/             # Modern Terraform feature examples
    ├── for_each.tf       # for_each & dynamic blocks
    ├── validation.tf     # Variable validation blocks
    ├── lifecycle.tf      # lifecycle meta-argument
    ├── moved.tf          # moved blocks (refactoring)
    ├── import.tf         # import blocks (Terraform 1.5+)
    ├── check.tf          # check blocks (continuous assertions)
    ├── removed.tf        # removed blocks (safe removal)
    └── terraform_test/   # Native terraform test (1.6+)
```

## What You'll Learn

| Concept | Where to Find It |
|---------|-----------------|
| Provider & version constraints | `terraform.tf` |
| Variables with validation | `variables.tf`, `examples/validation.tf` |
| EC2, Security Groups, Key Pairs | `ec2.tf` |
| user_data bootstrapping | `ec2.tf` + `script.sh` |
| S3 with versioning & encryption | `s3.tf` |
| DynamoDB tables | `dynamodb.tf` |
| Outputs | `outputs.tf` |
| Reusable modules | `aws_module_project/` |
| Multi-environment with modules | `aws_module_project/main.tf` |
| EKS cluster (v21.x) | `eks/` |
| VPC for Kubernetes | `eks/vpc.tf` |
| for_each & dynamic blocks | `examples/for_each.tf` |
| Lifecycle rules | `examples/lifecycle.tf` |
| Import existing resources | `examples/import.tf` |
| Refactoring with moved | `examples/moved.tf` |
| Continuous assertions | `examples/check.tf` |
| Safe resource removal | `examples/removed.tf` |
| terraform test framework | `examples/terraform_test/` |

---

## Terraform Commands — Complete Guide

### 1. Setup & Initialization

**Install Terraform (Linux/Ubuntu)**
```sh
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Verify installation
terraform -v
```

**Install Terraform (macOS)**
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**Initialize Terraform**
```sh
terraform init
```
- Downloads provider plugins
- Sets up the working directory

### 2. Core Commands
```sh
terraform fmt           # Format code to standard style
terraform validate      # Validate syntax and configuration
terraform plan          # Preview changes without applying
terraform apply         # Create/update infrastructure
terraform apply -auto-approve  # Apply without confirmation
terraform destroy       # Destroy all managed resources
terraform destroy -auto-approve  # Destroy without confirmation
```

### 3. Managing State
```sh
terraform state list              # List all managed resources
terraform show                    # Show detailed resource info
terraform state mv <src> <dest>   # Move resource in state
terraform state rm <resource>     # Remove from state (not from cloud)
```

**Remote Backend (S3)**
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}
```

### 4. Variables & Outputs
```sh
terraform apply -var="instance_type=t3.small"  # Pass variable via CLI
terraform output                                # Show all outputs
terraform output ec2_public_ip                  # Show specific output
```

### 5. Workspaces
```sh
terraform workspace new dev       # Create workspace
terraform workspace select prod   # Switch workspace
terraform workspace list          # List all workspaces
```

### 6. Testing (Terraform 1.6+)
```sh
terraform test                    # Run all .tftest.hcl files
```

### 7. Debugging
```sh
export TF_LOG=DEBUG               # Enable debug logs
terraform apply 2>&1 | tee debug.log
```

---

## Projects

### Terraform with Ansible
[Get it here](https://github.com/LondheShubham153/terraform-ansible-multi-env)

### Terraform with GitHub
[Get it here](https://github.com/Amitabh-DevOps/online_shop/tree/github-action/.github/workflows)

### Terraform to EKS
[Get it here](https://github.com/DevMadhup/Springboot-BankApp/tree/DevOps/Terraform/EKS-Deployment)
