terraform {
  # Store Terraform state in S3 so different runs and machines can share
  # the same source of truth for this stack.
  backend "s3" {
    bucket       = "jerry961"
    region       = "us-east-1"
    key          = "End-to-End-Kubernetes-DevSecOps-Tetris-Project/EKS-TF/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }

  # Require a recent Terraform CLI version so the configuration behaves
  # consistently for anyone applying this folder.
  required_version = ">=1.13.3"

  # Pin the AWS provider family used by this folder.
  required_providers {
   aws = {
      source  = "hashicorp/aws"
      version = "6.50.0"
    }
  }
}
