resource "vault_audit" "file" {
  type        = "file"
  description = "write audit logs to file"

  options = {
    mode      = "0000" # don't modify existing permissions
    file_path = "/var/log/vault-audit.log"
  }
}
