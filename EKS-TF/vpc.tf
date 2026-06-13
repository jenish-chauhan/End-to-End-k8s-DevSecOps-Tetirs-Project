data "aws_vpc" "vpc" {
  # Reuse the VPC created earlier instead of creating another network here.
  filter {
    name   = "tag:Name"
    values = [var.vpc-name]
  }
}

data "aws_internet_gateway" "igw" {
  # Reuse the VPC's existing internet gateway so the new subnet can reach the internet.
  filter {
    name   = "tag:Name"
    values = [var.igw-name]
  }
}

data "aws_subnet" "subnet" {
  # Reuse the first public subnet that already exists in the shared VPC.
  filter {
    name   = "tag:Name"
    values = [var.subnet-name]
  }
}

data "aws_security_group" "sg-default" {
  # Reuse an existing security group rather than defining a new one in this stack.
  filter {
    name   = "tag:Name"
    values = [var.security-group-name]
  }
}

resource "aws_subnet" "public-subnet2" {
  # Add a second public subnet in another Availability Zone so EKS can span
  # multiple subnets, which is required for a production-style cluster layout.
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name2
  }
}

resource "aws_route_table" "rt2" {
  # Give the new subnet a default route to the internet through the reused IGW.
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt-name2
  }
}

resource "aws_route_table_association" "rt-association2" {
  # Attach the route table to the second subnet so its instances or nodes
  # can actually use that internet route.
  route_table_id = aws_route_table.rt2.id
  subnet_id      = aws_subnet.public-subnet2.id
}
