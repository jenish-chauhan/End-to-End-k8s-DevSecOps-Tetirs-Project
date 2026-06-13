resource "aws_vpc" "vpc" {
  # Create an isolated network for the Jenkins and SonarQube host.
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_internet_gateway" "igw" {
  # Attach an internet gateway so resources in public subnets can reach the internet.
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw-name
  }
}

resource "aws_subnet" "public-subnet" {
  # Public subnet where the Jenkins EC2 instance is launched.
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name
  }
}

resource "aws_route_table" "rt" {
  # Route outbound traffic from the public subnet to the internet gateway.
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt-name
  }
}

resource "aws_route_table_association" "rt-association" {
  # Bind the public subnet to the route table so the route becomes active there.
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.public-subnet.id
}

resource "aws_security_group" "security-group" {
  # Open the ports required for administration and the tools hosted on the box.
  # These rules are public, which is convenient for a lab but broad for production.
  vpc_id      = aws_vpc.vpc.id
  description = "Allowing Jenkins, Sonarqube, SSH Access"

  ingress = [
    # Generate one ingress rule each for:
    # - 22   -> SSH
    # - 8080 -> Jenkins UI
    # - 9000 -> SonarQube UI
    for port in [22, 8080, 9000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      security_groups  = []
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress {
    # Allow the instance to reach package repositories, AWS APIs, Docker Hub, etc.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg-name
  }
}
