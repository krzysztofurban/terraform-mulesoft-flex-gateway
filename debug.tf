data "anypoint_flexgateway_targets" "targets" {
  org_id = var.root_org
  env_id = var.env_id
}

output "debug_targets" {
  value = data.anypoint_flexgateway_targets.targets
  description = "List possible targets in the environment"
}
