resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "main" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = count.index == 0 ? "10.0.1.0/24" : "10.0.2.0/24"
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "MainSubnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "main" {
  name        = "my-db-subnet-group"
  subnet_ids  = aws_subnet.main.*.id

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

resource "aws_db_parameter_group" "mysql8" {
  name        = "mysql8-parameter-group"
  family      = "mysql8.0"  # Asegúrate de que esto coincide con la familia de la versión de tu motor
  description = "Custom parameter group for MySQL 8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS MySQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Especifica tu CIDR adecuadamente para mayor seguridad
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDSMySQLSecurityGroup"
  }
}

