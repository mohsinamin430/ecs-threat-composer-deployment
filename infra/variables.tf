variable "region" {
  description = "AWS region to deploy resources"
  type = string
  default = "eu-west-2"
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}