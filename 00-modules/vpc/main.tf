provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
      Name  = var.vpc_name
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "vpc internet gw"
  }
}
