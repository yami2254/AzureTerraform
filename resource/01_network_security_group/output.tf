
output "network_security_name"{
  value = var.security_group_name
}

output "resource_group_name" {
 value = var.resource_group_name
}

output "imbound_rule" {
  value = var.inbound_rules
}

output "outbound_rule" {
  value = var.outbound_rules
}
