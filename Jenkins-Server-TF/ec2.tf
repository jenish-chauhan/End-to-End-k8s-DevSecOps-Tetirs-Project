resource "aws_instance" "ec2" {
  # Single EC2 host that runs Jenkins and additional DevSecOps tooling.
  ami                    = var.ami
  instance_type          = "t3.xlarge"
  key_name               = var.key-name
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name

  root_block_device {
    # Increase the default root disk so Jenkins, Docker images, and scans have space.
    volume_size = 30
  }

  # Bootstrap the server on first launch with Jenkins, Docker, SonarQube,
  # Terraform, kubectl, AWS CLI, and Trivy.
  user_data = templatefile("./tools-install.sh", {})

  tags = {
    Name = var.instance-name
  }
}
