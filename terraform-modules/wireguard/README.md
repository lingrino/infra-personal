# Wireguard

This module sets up a wireguard instance with an elastic IP. It is in an autoscaling group and will attach the elastic IP each time it boots. The configuration for wireguard in the module is *my* configuration. If you want to use this module fork it and change to use your configuration. Secrets are not stored in this module, instead they are stored in aws secrets manager and read/templated by the wireguard instance in userdata.

## Usage

```terraform
module "wireguard" {
  source = "../../../../terraform-modules/wireguard//"

  name_prefix = "wireguard"

  zone_name   = "example.com"
  domain_name = "vpn.example.com"

  vpc_id  = "vpc-fjf30923m"
  subnets = ["subnet-123", "subnet-456"]

  ami_owner_id  = "0123456789"
  instance_type = "t3.nano"
  key_name      = "main"

  wg_address = "192.168.10.0/24"
  wg_port    = "51820"

  tags = var.tags
}
```

## Wireguard Secrets

Do not store your wireguard private keys in this module. Instead the module creates a secrets manager key where you should store them in the following json format.

```json
{
    "description": "Every VALUE in replacements will globally replace every KEY in the file",
    "file": "/etc/wireguard/wg0.conf",
    "replacements": {
        "SERVER_PRIVATE_KEY": "fksjdfnsdkjfhskjfld",
        "PHONE_PRIVATE_KEY": "ldksjfslekfjwekljflkwejf"
    }
}
```

What this secret means is that during userdata the wireguard instance will, for each KEY in `.replacements` run `sed -i -e "s/$key/$value/g" "$file"` where value is the corresponding value and file is the value of the `file` key in the secret. Store your private keys in this format in the secret created by terraform and then in your `wg0.conf` store values that will be replaced on boot.

## Updating Configuartion

If you need to update the configuration first modify the file in this module and apply the terraform. Next terminate the currently running instance and soon a new one will appear with the new configuration and same IP.
