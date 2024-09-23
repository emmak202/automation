variable "ami_type" {
  type = string
  default = "ami-01ec84b284795cbc7"
}

variable "instance_count" {
  type = number
  default = 2
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_id" {
  
}

variable "public_subnet_id" {
  
}