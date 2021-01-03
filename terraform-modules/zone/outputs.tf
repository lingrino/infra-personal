output "zone_id" {
  description = "The ID of the created zone"
  value       = cloudflare_zone.zone.id
}

output "nameservers" {
  description = "A list of the nameservers for the created zone"
  value       = cloudflare_zone.zone.name_servers
}
