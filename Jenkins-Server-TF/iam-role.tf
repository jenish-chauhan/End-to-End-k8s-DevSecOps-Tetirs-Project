resource "aws_iam_role" "iam-role" {
  # EC2 instance role so the Jenkins server can call AWS APIs.
  name = var.iam-role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
