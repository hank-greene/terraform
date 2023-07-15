provider "aws" {
    region = "us-east-1"
}

module "cms" {
    source = "../../00-modules/cms"
}