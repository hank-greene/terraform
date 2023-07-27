# input 
variable "environment_variables" {
    type = map(string)
    default = {
        dev = "dev"
        staging = "staging"
        prod = "prod"
    }
}

variable "vpc_name" {
    description = "the vpc"
    type = string
    default = "the_vpc"
}

variable "aws_internet_gateway" {
  description = "inet gatway"
  type = string
  default = "net set"
}

variable "aws_route_table" {
    description = "vpc route table"
    type = string
    default = "not set"
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

variable "aws_route_table_association" {
    description = "route table association"
    type = string
    default = "not set"
}

variable "azs" {
    description = "availability zone"
    type = list(string)
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "vpc_cidr_block" {
    description = "IP range"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_enable_nat_gateway" {
    description = "nat gateway"
    type = bool
    default = true
}

variable "vpc_tags" {
    description = "vpc module tags"
    type = map(string)
    default = {
        Terraform = "true"
        Environment = "dev"
    }
}
