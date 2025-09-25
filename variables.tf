variable security_group {
    type        = list(string)
}

variable key_name {
    type        = string
}

variable "subnet_id" {
  description = "The Subnet ID to use"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to use"
  type        = string
}
