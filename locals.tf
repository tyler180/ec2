locals {
  ec2_instance_types = ["t2.micro"]

  sqs_queues = toset(["terraform-example-queue"])
}