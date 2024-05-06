resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = aws_db_parameter_group.mysql8.name
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "TierMySQLInstance"
  }
}



