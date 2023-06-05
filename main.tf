
module "dev" {
   source = "./01-environments/01-dev"
}

module "staging" {
   source = "./01-environments/02-staging"
}


module "prod" {
   source = "./01-environments/03-prod"
}

