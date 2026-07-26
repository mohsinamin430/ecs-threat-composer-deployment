#Creates an ECR repository for the Docker image
resource "aws_ecr_repository" "threatapp_repo" {
  name                 = "threatapp_repo"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

#s3 bucktet for terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-threatapp"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}