variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "sessionkey"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_groups" {
  description = "Name of security group"
  default     = "sg-0c831a19e5d39c35e"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "my-ec2-instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-0ac59804e0c10a625"
}

variable "subnet_id" {
  description = "vpc security group"
  default     = "subnet-0764ebfa212f95616"
}
