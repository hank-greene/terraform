variable "vpc_name" {
    description = "vpc_name"
    type = string
    default = "dev-drupal"
}

variable "public_cidr" {
    description = "public cidr block"
    type = string
    default = "10.0.0.0/16"
}

variable "private_cidr" {
    description = "private cidr block"
    type = string
    default = "10.0.1.0/24"
    //type = list(string)
    //default = ["10.0.1.0/24","10.0.2.0/24"]
}
