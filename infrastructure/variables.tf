variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "pubkey_location" {
  description = "EC2 public key location"
  type        = string
}