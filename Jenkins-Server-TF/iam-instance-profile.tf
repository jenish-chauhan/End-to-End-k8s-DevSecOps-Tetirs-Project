resource "aws_iam_instance_profile" "instance-profile" {
  # EC2 instances cannot attach a role directly; they use an instance profile wrapper.
  name = "Jenkins-instance-profile"
  role = aws_iam_role.iam-role.name
}
