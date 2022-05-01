#create security group for web
resource "aws_security_group" "web_security_group" {
  name        = "web_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.altimonia_vpc.id
  tags = {
    Name = "altimonia_vpc_web_security_group"
  }
}

#create security group ingress rule for web
resource "aws_security_group_rule" "web_ingress" {
  count             = length(var.web_ports)
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = element(var.web_ports, count.index)
  to_port           = element(var.web_ports, count.index)
  security_group_id = aws_security_group.web_security_group.id
}

#create security group egress rule for web
resource "aws_security_group_rule" "web_egress" {
  count             = length(var.web_ports)
  type              = "egress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = element(var.web_ports, count.index)
  to_port           = element(var.web_ports, count.index)
  security_group_id = aws_security_group.web_security_group.id
}

#create security group for db
resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.altimonia_vpc.id
  tags = {
    Name = "altimonia_vpc_db_security_group"
  }
}

#create security group ingress rule for db
resource "aws_security_group_rule" "db_ingress" {
  count             = length(var.db_ports)
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = element(var.db_ports, count.index)
  to_port           = element(var.db_ports, count.index)
  security_group_id = aws_security_group.db_security_group.id
}

#create security group egress rule for db
resource "aws_security_group_rule" "db_egress" {
  count             = length(var.db_ports)
  type              = "egress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = element(var.db_ports, count.index)
  to_port           = element(var.db_ports, count.index)
  security_group_id = aws_security_group.db_security_group.id
}

#create aws rds subnet groups
resource "aws_db_subnet_group" "altimonia_database_subnet_group" {
  name       = "altimonia-db-sg"
  subnet_ids = [aws_subnet.altimonia_vpc_private_subnet_one.id, aws_subnet.altimonia_vpc_private_subnet_two.id]
  tags = {
    Name = "altimonia_database_subnet_group"
  }
}
