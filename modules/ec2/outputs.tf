output "instance_id" {
  description = "ID of the Windows API instance"
  value       = aws_instance.windows_api.id
}

output "public_ip" {
  description = "Public IP of the Windows API instance"
  value       = aws_instance.windows_api.public_ip
}

output "private_ip" {
  description = "Private IP of the Windows API instance"
  value       = aws_instance.windows_api.private_ip
}

output "security_group_id" {
  description = "Security group ID for the Windows API instance"
  value       = aws_security_group.windows_api.id
}

output "key_pair_name" {
  description = "Name of the generated key pair"
  value       = aws_key_pair.windows_api.key_name
}

output "private_key_path" {
  description = "Path to the generated private key file"
  value       = local_file.windows_api_private_key.filename
}


