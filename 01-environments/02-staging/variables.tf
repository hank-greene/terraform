// spacelift.io/blog/terraform-aws-vpc 

variable "vpc_name" {
    description = "vpc_name"
    type = string
    default = "staging-drupal"
}

variable "vpc_cidr_block" {
    default = "10.2.0.0/16"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "public subnet cidr values"
    default = ["10.2.1.0/24","10.2.2.0/24","10.2.3.0/24"]
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "private subnet cidr values"
    default = ["10.2.4.0/24","10.2.5.0/24","10.2.6.0/24"]
}

variable "azs" {
    type = list(string)
    description = "availability zones"
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}