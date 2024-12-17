
#######################################
# Data Sources
#######################################

data "aws_vpc" "lanchonete_vpc" {
  tags = {
    Name = "lanchonete-vpc"
  }
}

data "aws_subnet" "lanchonete_public_subnet_a" {
  vpc_id = data.aws_vpc.lanchonete_vpc.id
  tags = {
    Name = "lanchonete-public-subnet-a"
  }
}

data "aws_subnet" "lanchonete_public_subnet_b" {
  vpc_id = data.aws_vpc.lanchonete_vpc.id
  tags = {
    Name = "lanchonete-public-subnet-b"
  }
}

#######################################
# Security Groups
#######################################

module "lanchonete_rds_sg" {
  source              = "./modules/aws/security_group"
  vpc_id              = data.aws_vpc.lanchonete_vpc.id
  ingress_port        = 5432
  ingress_protocol    = "tcp"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  name                = "lanchonete-rds-sg"
}

#######################################
# RDS Instance
#######################################

module "lanchonete_rds" {
  source                 = "./modules/aws/rds"
  identifier             = "lanchonete"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  username               = var.rds_username
  password               = var.rds_password
  publicly_accessible    = true
  vpc_security_group_ids = [module.lanchonete_rds_sg.security_group_id]
  name                   = "lanchonete-rds"
  subnet_group_name      = "lanchonete-subnet-group"
  db_name                = var.rds_db_name
  parameter_group_name   = "postgres16"

  subnet_ids = [
    data.aws_subnet.lanchonete_public_subnet_a.id,
    data.aws_subnet.lanchonete_public_subnet_b.id
  ]
}
