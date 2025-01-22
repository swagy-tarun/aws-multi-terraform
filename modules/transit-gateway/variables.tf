variable "description" {
  description = "Description of the transit gateway"
  type        = string
  default     = "Transit Gateway"
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway"
  type        = number
  default     = 64512
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "association" {
  description = "Default route table association behavior."
  type        = string
  default     = "disable"
}

variable "propagation" {
  description = "Default route table propagation behavior."
  type        = string
  default     = "disable"
}

variable "auto_accept_shared_attachments" {
  description = "Accept shared attachments automatically"
  type        = string
  default     = "disable"
}
