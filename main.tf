provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0dcb8b47acab56894"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}