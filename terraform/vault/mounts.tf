resource "vault_mount" "cubbyhole" {
  type        = "cubbyhole"
  path        = "cubbyhole"
  description = "per-token private secret storage"
  local       = true
}

resource "vault_mount" "identity" {
  type        = "identity"
  path        = "identity"
  description = "identity store"
}

resource "vault_mount" "sys" {
  type        = "system"
  path        = "sys"
  description = "system endpoints used for control, policy and debugging"
}

resource "vault_mount" "kv" {
  type        = "kv"
  path        = "kv"
  description = "key/value storage"

  options = {
    version = "2"
  }
}
