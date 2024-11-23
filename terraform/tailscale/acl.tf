resource "tailscale_acl" "acl" {
  acl = <<-EOF
    {
      "acls": [
        {
          "action": "accept",
          "src":    ["*"],
          "dst":    ["*:*"],
        },
      ],
      "ssh": [
        {
          "action": "check",
          "src":    ["autogroup:member"],
          "dst":    ["autogroup:self"],
          "users":  ["autogroup:nonroot", "root"],
        },
      ],
      "nodeAttrs": [
        {
          "attr":   ["funnel"],
          "target": ["autogroup:member"],
        },
      ],
    }
  EOF
}
