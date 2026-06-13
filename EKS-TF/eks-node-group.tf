resource "aws_eks_node_group" "eks-node-group" {
  # Create the managed worker nodes that will run application pods.
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.eksnode-group-name
  node_role_arn   = aws_iam_role.NodeGroupRole.arn

  # Place nodes in both public subnets so the node group is spread across AZs.
  subnet_ids = [data.aws_subnet.subnet.id, aws_subnet.public-subnet2.id]

  scaling_config {
    # Keep one node minimum, start with two, and allow scale-out to three.
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # Worker nodes use a modest instance type and 20 GB root volume.
  instance_types = ["t3.medium"]
  disk_size      = 20

  # The node role must have all required policies before EKS can create nodes.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}
