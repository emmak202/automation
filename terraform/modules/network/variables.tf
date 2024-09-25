variable "vpc_cidr" {
    type = string
    default = "192.168.10.0/24"  
}

variable "public1_cidr" {
  default = "192.168.10.0/26"
}

variable "private1_cidr" {
  default = "192.168.10.64/26"
}
