variable "vpc-cidrblock" {
    type = string
    default = "10.0.0.0/16"
}

variable "public-subnet-cidrblock" {
    type = string
    default = "10.0.1.0/24"
}
