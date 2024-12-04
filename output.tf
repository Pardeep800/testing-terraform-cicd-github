output "vpc_id" {
  value       = aws_vpc.main[0].id
  description = "The ID of the VPC"
}

output "ec2_instance_id" {
  value       = aws_instance.main[0].id
  description = "The ID of the EC2 instance"
}

output "asg_name" {
  value       = aws_autoscaling_group.main[0].name
  description = "The name of the Auto Scaling Group"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.main[0].bucket
  description = "The name of the S3 bucket"
}
