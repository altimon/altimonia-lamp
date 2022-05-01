#create aws mysql rds instance
resource "aws_db_instance" "altimonia_database_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  port                   = 3306
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.altimonia_database_subnet_group.name
  db_name                = var.dbname
  identifier             = var.dbidentifier
  username               = var.dbusername
  password               = var.dbpassword
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  tags = {
    Name = "altimonia_database_instance"
  }
}
