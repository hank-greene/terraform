provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "dev-drupal" {
    cidr_block = var.vpc_cidr_block
    tags = {
      Name  = "dev-drupal-vpc"
    }
}
// spacelift.io/blog/terraform-aws-vpc 

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.dev-drupal.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "public subnet ${ count.index + 1 }"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.dev-drupal.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "private subnet ${ count.index + 1 }"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev-drupal.id

  tags = {
    Name = "vpc internet gw"
  }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.dev-drupal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd route table"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.second_rt.id
}

/****

resource "aws_security_group" "dev-drupal-sg" {
    name = "dev-drupal-sg"
}

resource "aws_security_group" "sg_vpc_dev_us_east_1" {
  vpc_id = aws_vpc.dev-drupal.id
  depends_on = [aws_vpc.dev-drupal]
  tags = {
    Name = "SG : vpc-dev-us-east-1 "
  }
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

resource "aws_instance" "app_server" {
  ami = "ami-0fec2c2e2017f4e7b"
  instance_type = "t2.micro"
  key_name = aws_key_pair.dev_phn_key.key_name
  subnet_id = aws_vpc.dev-drupal
  vpc_security_groups_ids = []
  associate_public_ip_address = true
  tags = {
    Name = "Dev-Drupal"
  }
}

resource "aws_efs_file_system" "dev_efs" {
  creation_token = "efs"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted = "true"
  tags = {
    Name = "Dev-EFS"
  }
}

resource "aws_security_group" "dev_efs_sg" {
  name = "dev-efs-traffic"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.dev-drupal.id

  tags = {
    Name = "efs-traffic"
    Product = "drupal-efs"
  }

  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_mount_target" "dev_mount_targets" {
  count = 2
  file_system_id = aws_efs_fuile_system.dev_efs.id
  subnet_id = aws_instance.app_server.subnet_id
  security_groups = [aws_security_group.dev_efs_sg.id]
}
**/