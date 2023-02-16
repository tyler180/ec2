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

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "production"
}

data "hcp_packer_image" "ubuntu_us_east_2" {
  bucket_name    = "learn-packer-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-east-2"
}


resource "aws_instance" "app_server" {
  ami           = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}