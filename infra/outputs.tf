output "lanchonete_rds_security_group_id" {
  value = module.lanchonete_rds_sg.security_group_id
}

output "lanchonete_rds_endpoint" {
  value = module.lanchonete_rds.rds_endpoint
}
