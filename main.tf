provider "aws" {
    region = "us-east-1"
}

module "vpc" {
   source = "./00-modules/vpc"
}

module "dev" {
   source = "./01-environments/01-dev"
   vpc_id = module.vpc.vpc_id
   aws_internet_gateway = module.vpc.gw_id
}

module "staging" {
   source = "./01-environments/02-staging"
   vpc_id = module.vpc.vpc_id
   aws_internet_gateway = module.vpc.gw_id
}

/***
module "prod" {
   source = "./01-environments/03-prod"
}
****/