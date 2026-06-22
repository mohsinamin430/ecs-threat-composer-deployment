#Creates an ECR repository for the Docker image
resource "aws_ecr_repository" "threatapp-repo" {
  name                 = "threatapp-repo"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

