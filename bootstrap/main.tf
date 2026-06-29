module "ECR" {
  source = "./modules/ecr"
}

module "S3" {
  source = "./modules/s3"
}