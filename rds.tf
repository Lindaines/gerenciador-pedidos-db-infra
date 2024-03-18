resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "15.2"
  instance_class       = "db.t3.medium"
  name                 = "lanchonete"
  username             = var.rds_db_user
  password             = var.rds_db_password
  parameter_group_name = "default.postgres12"
  final_snapshot_identifier = "pgsql-snapshot"

  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "LanchoneteGerenciadorPedidos"
  }
}

resource "aws_security_group" "instance" {
  name = "lanchonete-security-group"
  
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "address" {
  description = "The address to connect to the DB instance."
  value       = aws_db_instance.default.address
}

output "arn" {
  description = "The ARN of the DB instance."
  value       = aws_db_instance.default.arn
}