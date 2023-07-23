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

variable "vpc_azs" {
    description = "availability zone"
    type = list(string)
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "vpc_cidr_block" {
    description = "IP range"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
    description = "private subnets"
    type = list(string)
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "vpc_public_subnets" {
    description = "public subnets"
    type = list(string)
    default = ["10.0.10.0/24","10.0.20.0/24","10.0.30.0/24"]
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

variable "aws_internet_gateway" {
  description = "inet gatway"
  type = string
  default = "net set"
}

