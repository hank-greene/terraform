// spacelift.io/blog/terraform-aws-vpc 

variable "vpc_name" {
    description = "vpc_name"
    type = string
    default = "prod-drupal"
}

variable "vpc_cidr_block" {
    default = "10.3.0.0/16"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "public subnet cidr values"
    default = ["10.3.1.0/24","10.3.2.0/24","10.3.3.0/24"]
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "private subnet cidr values"
    default = ["10.3.4.0/24","10.3.5.0/24","10.3.6.0/24"]
}

variable "azs" {
    type = list(string)
    description = "availability zones"
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}