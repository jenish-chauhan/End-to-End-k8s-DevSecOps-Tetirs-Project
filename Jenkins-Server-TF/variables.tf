variable "vpc-name" {
  description = "Name tag for the VPC created for the Jenkins environment."
}

variable "igw-name" {
  description = "Name tag for the internet gateway attached to the Jenkins VPC."
}
variable "ami" {
  description = "The AMI ID for the EC2 instance that will host Jenkins."
  type        = string
  
  
}

variable "rt-name" {
  description = "Name tag for the route table that gives the public subnet internet access."
}

variable "subnet-name" {
  description = "Name tag for the public subnet where the Jenkins EC2 instance will run."
}

variable "sg-name" {
  description = "Name tag for the security group allowing access to Jenkins, SonarQube, and SSH."
}

variable "instance-name" {
  description = "Name tag for the EC2 instance that hosts the Jenkins server."
}

variable "key-name" {
  description = "Existing AWS key pair name used for SSH access to the EC2 instance."
}

variable "iam-role" {
  description = "Name of the IAM role attached to the Jenkins EC2 instance."
}
