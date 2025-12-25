terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }

  # --- NEW: TELL TERRAFORM TO USE S3 ---
  backend "s3" {
    bucket = "tf-state-praveen2-2025"  # Your new bucket name
    key    = "terraform.tfstate"      # The name of the file to save
    region = "us-east-1"              # The region of your bucket
  }
  # -------------------------------------
}

provider "aws" {
  region = var.aws_region # us-east-1 from variables.tf
}

#1. Security_group Definition (Open SSH & Web)

resource "aws_security_group" "ops_sg" {
  name        = "ops_pipeline_sg"
  description = "Allow SSH and HTTP traffic"

  # Inbound Rule: Allow SSH (Port 22) from ANYWHERE
  ingress {
    description = "SSH from everywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: Allow HTTP (Port 80) from ANYWHERE <--- CRITICAL FOR WEBSITES
  ingress {
    description = "HTTP from everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule: Allow all traffic out (to download updates)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. The Server (Ubuntu)
resource "aws_instance" "app_server" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    key_name               = var.key_name
    vpc_security_group_ids = [aws_security_group.ops_sg.id]
    
tags = {
        Name = "Ops-Demo-Ubuntu"
    }
}