variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "tf-key2"  # Using your existing key
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
    default  = "ami-0e2c8caa4b6378d8c"
}