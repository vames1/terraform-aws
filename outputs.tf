output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
output "iam_user_name" {
  value = aws_iam_user.dev_user.name
}

output "iam_access_key_id" {
  value = aws_iam_access_key.dev_user_key.id
}

output "iam_secret_access_key" {
  value     = aws_iam_access_key.dev_user_key.secret
  sensitive = true
}
