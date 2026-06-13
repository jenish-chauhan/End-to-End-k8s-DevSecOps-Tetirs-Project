terraform {
  # Store state remotely so the Jenkins infrastructure can be managed
  # consistently across runs and collaborators.
  backend "s3" {
    bucket       = "backend-store-terraform-stat"
    region       = "us-east-1"
    key          = "End-to-End-Kubernetes-DevSecOps-Tetris-Project/Jenkins-Server-TF/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }

  # Require a supported Terraform version for this configuration.
  required_version = ">=1.13.3"

  # Pin the AWS provider family used by this folder.
  required_providers {
   aws = {
      source  = "hashicorp/aws"
      version = "6.50.0"
    }
  }
}
