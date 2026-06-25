variable "image_tag" {
  description = "Docker image tag/version to deploy from ECR"
  type        = string
  default     = "latest"
}

variable "ecr_repository_url" {
  description = "ECR repository URL for the Docker image"
  type        = string
}

variable "public_subnet_1_id" {
  description = "ID of the first public subnet"
  type        = string
}

variable "public_subnet_2_id" {
  description = "ID of the second public subnet"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where ECS service will be deployed"
  type        = string
}

variable "alb_tg_arn" {
  description = "ARN of the ALB target group for ECS service"
  type        = string
}

variable "https_listener_arn" {
  description = "ARN of the HTTPS listener for the ALB"
  type        = string
}