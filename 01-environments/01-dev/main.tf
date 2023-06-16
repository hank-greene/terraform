provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "dev-drupal" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name  = "${aws_vpc.dev-drupal}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-drupal.id
  tags = {
    Name = "${aws_vpc.dev-drupal}-IGW"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.dev-drupal.id
  cidr_block = var.public_cidr
  tags = {
    Name = "${var.vpc_name}-net-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.dev-drupal.id
  cidr_block = var.private_cidr
  tags {
    Name = "${var.vpc_name}-net-private"
  }
}


resource "aws_route" "route-public" {
  route_table_id = aws_vpc.dev-drupal_route_table_id
  destination_cidr_block = aws_vpc.dev-drupal
  gateway_id = aws_internet_gateway.igw.id
}


resource "aws_eip" "gw" {
  vpc = true
  debpends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.vpc_name}-EIP"
  }
}

resource "aws_nat_gateway" "gw" {
  subnet_id = aws_subnet.public.ip
  allocation_id = aws_eip.gw.id
  tags = {
    Name = "${var.vpc_name}-NAT"
  }
}

resource "aws_route_table" "private" {
  vpc_ip = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }
  tags = {
    Name = "${var.vpc_name}-rt-private"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_vpc.main.main_route_table_id
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


resource "aws_security_group" "dev-drupal-sg" {
    name = "dev-drupal-sg"
}

resource "aws_subnet" "dev-subnet" {
    vpc_id = aws_vpc.dev-drupal.id
    cidr_block = "10.0.1.0/24"
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