provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "dev-drupal" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "dev-drupal-sg" {
    name = "dev-drupal-sg"
}

resource "aws_subnet" "dev-subnet" {
    vpc_id = aws_vpc.dev-drupal.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "sg_vpc_dev_eu_central_1" {
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
  vpc_id = aws_vpc.vpc-jhooq-eu-central-1.id
  depends_on = [aws_vpc.vpc-jhooq-eu-central-1]
  tags = {
    Name = "SG : vpc-jhooq-eu-central-1 "
  }
}

resource "aws_instance" "app_server" {
  ami = "ami-"
  instance_type = "t2.micro"
  key_name = aws_key_pair.dev_phn_key.key_name
  subnet_id =
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
  vpc_id = ...

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
