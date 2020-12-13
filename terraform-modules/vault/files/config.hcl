cluster_name = "${ name_prefix }"
ui           = "true"

api_addr     = "https://${ domain_name }"
cluster_addr = "https://MY_IP_SET_IN_USERDATA:8201"

log_level  = "Error"
log_format = "json"

max_lease_ttl                = "192h" # One week
default_lease_ttl            = "192h" # One week
default_max_request_duration = "10s"

seal "awskms" {
  region     = "${ region }"
  kms_key_id = "${ kms_id }"
}

listener "tcp" {
  address     = "127.0.0.1:9200"
  tls_disable = "true"

  telemetry {
    unauthenticated_metrics_access = true
  }
}

listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"

  tls_disable     = "false"
  tls_min_version = "tls12"
  tls_cert_file   = "${ vault_config_dir }/crt.pem"
  tls_key_file    = "${ vault_config_dir }/key.pem"

  tls_prefer_server_cipher_suites = "true"
}

storage "dynamodb" {
  ha_enabled = "true"

  table  = "${ dynamo_name }"
  region = "${ region }"

  max_parallel = "512"
}

telemetry {
  disable_hostname      = true
  enable_hostname_label = true
  dogstatsd_addr        = "127.0.0.1:8125"

  dogstatsd_tags = [
    "service:${ name_prefix }"
  ]
}
