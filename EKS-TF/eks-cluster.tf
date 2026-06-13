resource "aws_eks_cluster" "eks-cluster" {
  # Create the managed Kubernetes control plane.
  name     = var.cluster-name
  role_arn = aws_iam_role.EKSClusterRole.arn

  # The control plane is attached to two public subnets:
  # - one existing subnet fetched from AWS
  # - one new subnet created in this folder
  vpc_config {
    subnet_ids         = [data.aws_subnet.subnet.id, aws_subnet.public-subnet2.id]
    security_group_ids = [data.aws_security_group.sg-default.id]
  }

  # Kubernetes version for the control plane.
  version = 1.33

  # Wait until the required IAM policy is attached, otherwise cluster creation fails.
  depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]
}
