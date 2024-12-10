locals {
  ec2_instance_types = ["t2.micro"]

  iam_roles = toset(["example-role"])
}