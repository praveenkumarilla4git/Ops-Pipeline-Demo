variable "aws_region" {
  description = "The AWS region to deploy the infrastructure"
  default     = "us-east-1"  # <--- CHANGED to North Virginia
}

variable "instance_type" {
  description = "The EC2 instance type"
  default = "t3.micro"   # <--- CHANGED: t2.micro is Free Tier in us-east-1
}

variable "key_name" {
  description = "Name of the SSH key pair to use"
  default     = "tf-key2"     # <--- You must create this key in North Virginia!
}