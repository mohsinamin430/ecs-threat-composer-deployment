module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
}

module "ecs" {
  source = "./modules/ecs"
  
  vpc_id = module.vpc.vpc_id
  ecr_repo_name = module.ecr.repository_name
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  alb_tg_arn = module.alb.alb_tg
}

module "ecr" {
  source = "./modules/ecr"
}

module "acm" {
  source = "./modules/acm"

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}
