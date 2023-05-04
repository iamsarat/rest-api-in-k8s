variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_bits" {
  type    = number
  default = 8
}

variable "tags" {
  description = "A map of tags added to all resources"
  type        = map(string)
  default = {
    "team:name"  = "DevOps"
    "team:owner" = "Sarat Koganti"
  }
}
