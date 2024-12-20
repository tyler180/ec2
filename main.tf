terraform {

  cloud {
    organization = "OliverREI"

    workspaces {
      name = "ec2"
    }
  }
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.54.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

# provider "hcp" {}

provider "aws" {
  region = var.region
}

# data "hcp_packer_iteration" "ubuntu" {
#   bucket_name = "learn-packer-ubuntu"
#   channel     = "production"
# }

# data "hcp_packer_version" "testing" {
#   bucket_name   = "learn-packer-ubuntu"
#   channel_name = "latest"
# }

# data "hcp_packer_artifact" "learn-packer-ubuntu" {
#   bucket_name   = "learn-packer-ubuntu"
#   channel_name  = "latest"
#   platform      = "aws"
#   region        = "us-east-2"
# }

# data "hcp_packer_image" "ubuntu_us_east_2" {
#   bucket_name    = "learn-packer-ubuntu"
#   cloud_provider = "aws"
#   iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
#   region         = "us-east-2"
# }


# resource "aws_instance" "app_server" {
#   # for_each = toset(local.ec2_instance_types)
#   ami           = "ami-0033fe31db68da96a"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }

resource "aws_iam_role" "example" {
  for_each = local.iam_roles
  name               = each.key
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


