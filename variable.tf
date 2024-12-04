variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "create_vpc" {
  description = "Set to true to create a VPC"
  type        = bool
  default     = false
}

variable "create_ec2" {
  description = "Set to true to create an EC2 instance"
  type        = bool
  default     = false
}

variable "create_s3" {
  description = "Set to true to create an S3 bucket"
  type        = bool
  default     = false
}

variable "create_asg" {
  description = "Set to true to create an Auto Scaling Group"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for EC2"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name for EC2 instance"
  type        = string
}
