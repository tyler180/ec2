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

provider "hcp" {}

provider "aws" {
  region = var.region
}

# data "hcp_packer_iteration" "ubuntu" {
#   bucket_name = "learn-packer-ubuntu"
#   channel     = "production"
# }

data "hcp_packer_version" "testing" {
  bucket_name   = "learn-packer-ubuntu"
  channel_name = "latest"
}

data "hcp_packer_artifact" "learn-packer-ubuntu" {
  bucket_name   = "learn-packer-ubuntu"
  channel_name  = "latest"
  platform      = "aws"
  region        = "us-east-2"
}

data "hcp_packer_image" "ubuntu_us_east_2" {
  bucket_name    = "learn-packer-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-east-2"
}


resource "aws_instance" "app_server" {
  # for_each = toset(local.ec2_instance_types)
  ami           = "ami-001651dd1b19ebcb6"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

