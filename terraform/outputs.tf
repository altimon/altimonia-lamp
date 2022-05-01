#output webserver and dbserver address
output "db_server_address" {
  value = aws_db_instance.altimonia_database_instance.address
}
output "web_server_address" {
  value = aws_instance.altimonia_web_instance.public_dns
}
