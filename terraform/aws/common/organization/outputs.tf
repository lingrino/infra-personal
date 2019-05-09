output "account_aliases" {
  description = "A list of all account aliases"
  value       = local.account_aliases
}

output "account_arns" {
  description = "A list of all account ARNs"
  value       = local.account_arns
}

output "account_ids" {
  description = "A list of all account IDs"
  value       = local.account_ids
}

output "account_names" {
  description = "A list of all account names"
  value       = local.account_names
}

output "account_aliases_to_account_arns" {
  description = "A map of all account aliases to their account ARNs"
  value       = zipmap(local.account_aliases, local.account_arns)
}

output "account_aliases_to_account_ids" {
  description = "A map of all account aliases to their account IDs"
  value       = zipmap(local.account_aliases, local.account_ids)
}

output "account_aliases_to_account_names" {
  description = "A map of all account aliases to their account names"
  value       = zipmap(local.account_aliases, local.account_names)
}

output "account_arns_to_account_aliases" {
  description = "A map of all account ARNs to their account aliases"
  value       = zipmap(local.account_arns, local.account_aliases)
}

output "account_arns_to_account_ids" {
  description = "A map of all account ARNs to their account ids"
  value       = zipmap(local.account_arns, local.account_ids)
}

output "account_arns_to_account_names" {
  description = "A map of all account ARNs to their account names"
  value       = zipmap(local.account_arns, local.account_names)
}

output "account_ids_to_account_aliases" {
  description = "A map of all account IDs to their account aliases"
  value       = zipmap(local.account_ids, local.account_aliases)
}

output "account_ids_to_account_arns" {
  description = "A map of all account IDs to their account arns"
  value       = zipmap(local.account_ids, local.account_arns)
}

output "account_ids_to_account_names" {
  description = "A map of all account IDs to their account names"
  value       = zipmap(local.account_ids, local.account_names)
}

output "account_names_to_account_aliases" {
  description = "A map of all account names to their account aliases"
  value       = zipmap(local.account_names, local.account_aliases)
}

output "account_names_to_account_arns" {
  description = "A map of all account names to their account ARNs"
  value       = zipmap(local.account_names, local.account_arns)
}

output "account_names_to_account_ids" {
  description = "A map of all account names to their account IDs"
  value       = zipmap(local.account_names, local.account_ids)
}
