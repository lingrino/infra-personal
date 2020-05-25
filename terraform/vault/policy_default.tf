resource "vault_policy" "default" {
  name   = "default"
  policy = data.vault_policy_document.default.hcl
}

data "vault_policy_document" "default" {
  rule {
    path         = "auth/token/lookup-self"
    capabilities = ["read"]
    description  = "Allow tokens to look up their own properties"
  }
  rule {
    path         = "auth/token/renew-self"
    capabilities = ["update"]
    description  = "Allow tokens to renew themselves"
  }
  rule {
    path         = "auth/token/revoke-self"
    capabilities = ["update"]
    description  = "Allow tokens to revoke themselves"
  }
  rule {
    path         = "sys/capabilities-self"
    capabilities = ["update"]
    description  = "Allow a token to look up its own capabilities on a path"
  }
  rule {
    path         = "identity/entity/id/{{identity.entity.id}}"
    capabilities = ["read"]
    description  = "Allow a token to look up its own entity by id"
  }
  rule {
    path         = "identity/entity/name/{{identity.entity.name}}"
    capabilities = ["read"]
    description  = "Allow a token to look up its own entity by name"
  }
  rule {
    path         = "sys/internal/ui/resultant-acl"
    capabilities = ["read"]
    description  = "Allow a token to look up its resultant ACL from all policies. This is useful for UIs. It is an internal path because the format may change at any time based on how the internal ACL features and capabilities change."
  }
  rule {
    path         = "sys/renew"
    capabilities = ["update"]
    description  = "Allow a token to renew a lease via lease_id in the request body; old path for old clients, new path for newer"
  }
  rule {
    path         = "sys/leases/renew"
    capabilities = ["update"]
    description  = "Allow a token to renew a lease via lease_id in the request body; old path for old clients, new path for newer"
  }
  rule {
    path         = "sys/leases/lookup"
    capabilities = ["update"]
    description  = "Allow looking up lease properties. This requires knowing the lease ID ahead of time and does not divulge any sensitive information."
  }
  rule {
    path         = "cubbyhole/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Allow a token to manage its own cubbyhole"
  }
  rule {
    path         = "sys/wrapping/wrap"
    capabilities = ["update"]
    description  = "Allow a token to wrap arbitrary values in a response-wrapping token"
  }
  rule {
    path         = "sys/wrapping/lookup"
    capabilities = ["update"]
    description  = "Allow a token to look up the creation time and TTL of a given response-wrapping token"
  }
  rule {
    path         = "sys/wrapping/unwrap"
    capabilities = ["update"]
    description  = "Allow a token to unwrap a response-wrapping token. This is a convenience to avoid client token swapping since this is also part of the response wrapping policy."
  }
  rule {
    path         = "sys/tools/hash"
    capabilities = ["update"]
    description  = "Allow general purpose tools"
  }
  rule {
    path         = "sys/tools/hash/*"
    capabilities = ["update"]
    description  = "Allow general purpose tools"
  }
  rule {
    path         = "sys/control-group/request"
    capabilities = ["update"]
    description  = "Allow checking the status of a Control Group request if the user has the accessor"
  }
}
