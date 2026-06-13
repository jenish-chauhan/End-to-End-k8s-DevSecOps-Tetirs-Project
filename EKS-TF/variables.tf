variable "vpc-name" {
  description = "Tag name of the existing VPC that EKS should reuse."
}

variable "igw-name" {
  description = "Tag name of the existing internet gateway attached to that VPC."
}

variable "rt-name2" {
  description = "Name tag for the additional route table created for the second subnet."
}

variable "subnet-name" {
  description = "Tag name of the existing public subnet that already exists in the VPC."
}

variable "subnet-name2" {
  description = "Name tag for the second public subnet this folder creates for EKS."
}

variable "security-group-name" {
  description = "Tag name of the existing security group attached to the EKS control plane."
}

variable "iam-role-eks" {
  description = "Informational variable for the EKS control plane role name; the role resource currently uses a fixed name."
}

variable "iam-role-node" {
  description = "Informational variable for the worker node role name; the role resource currently uses a fixed name."
}

variable "iam-policy-eks" {
  description = "Informational variable for the EKS control plane policy attachment."
}

variable "iam-policy-node" {
  description = "Informational variable for the worker node policy attachments."
}

variable "cluster-name" {
  description = "Name of the EKS cluster to create."
}

variable "eksnode-group-name" {
  description = "Name of the managed node group that will join the cluster."
}
