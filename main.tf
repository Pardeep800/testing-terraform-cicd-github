provider "aws" {
  region = var.aws_region
}

# Create VPC if enabled
resource "aws_vpc" "main" {
  count       = var.create_vpc ? 1 : 0
  cidr_block  = "10.0.0.0/16"
}

# Create Subnet if VPC is created
resource "aws_subnet" "main" {
  count       = var.create_vpc ? 1 : 0
  vpc_id      = aws_vpc.main[0].id
  cidr_block  = "10.0.1.0/24"
}

# Create EC2 instance if enabled (optional, based on user input)
resource "aws_instance" "main" {
  count             = var.create_ec2 ? 1 : 0
  ami               = var.ami_id
  instance_type     = "t2.micro"
  subnet_id         = var.subnet_id
  security_groups   = [var.security_group_id]
  key_name          = var.key_pair_name
}

# Create S3 bucket if enabled
resource "aws_s3_bucket" "main" {
  count = var.create_s3 ? 1 : 0
  bucket = "my-terraform-bucket-19087887"
  acl    = "private"
}

# Launch Template for Auto Scaling Group (Recommended for newer AWS accounts)
resource "aws_launch_template" "main" {
  count = var.create_asg ? 1 : 0

  name_prefix       = "asg-launch-template"
  image_id          = var.ami_id
  instance_type     = "t2.micro"
  vpc_security_group_ids = [var.security_group_id] # Corrected argument
  key_name          = var.key_pair_name
}

# Auto Scaling Group (ASG) to scale EC2 instances
resource "aws_autoscaling_group" "main" {
  count = var.create_asg ? 1 : 0

  desired_capacity     = 2
  max_size             = 5
  min_size             = 1
  vpc_zone_identifier  = [var.subnet_id]
  launch_template { # Corrected block structure
    id      = aws_launch_template.main[0].id
    version = "$Latest"
  }
  health_check_type    = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "AutoScalingInstance"
    propagate_at_launch = true
  }
}
