# variables.tf

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {}
}

# vpc-module/variables.tf

variable "public_subnets" {
  description = "List of public subnets"
  type = list(object({
    name            = string
    cidr_block      = string
    availability_zone = string
  }))
  default = []
}

variable "private_subnets" {
  description = "List of private subnets"
  type = list(object({
    name            = string
    cidr_block      = string
    availability_zone = string
  }))
  default = []
}