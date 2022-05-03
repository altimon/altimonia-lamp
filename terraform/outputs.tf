#output webserver and dbserver address
output "db_server_address" {
  value = aws_db_instance.altimonia_database_instance.address
}

output "web_server_address" {
  value = aws_instance.altimonia_web_instance.public_dns
}

# output "repository_name" {
#   value = aws_ecr_repository.altimonia.name
# }

output "repository_url" {
  value = aws_ecr_repository.altimonia.repository_url
}

# ALB external DNS name
output "alb_url" {
  value = "http://${aws_alb.altimonia_api_alb.dns_name}"
}
