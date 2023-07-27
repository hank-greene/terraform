// spacelift.io/blog/terraform-aws-vpc 
variable "vpc_id" {
    description = "vpc id"
    type = string
}

variable "aws_internet_gateway" {
  description = "inet gatway"
  type = string
  default = "net set"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "public subnet cidr values"
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "private subnet cidr values"
    default = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}

/******
variable "vpc_name" {
    description = "vpc_name"
    type = string
    default = "dev-drupal"
}

variable "vpc_cidr_block" {
    default = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "public subnet cidr values"
    default = ["10.1.0.0/24","10.1.0.0/24","10.1.0.0/24"]
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "private subnet cidr values"
    default = ["10.1.4.0/24","10.1.5.0/24","10.1.6.0/24"]
}

variable "azs" {
    type = list(string)
    description = "availability zones"
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
******/