#!/bin/bash

# Get Configuration and SSL Certs
aws --region ${ region } s3 cp s3://${ bucket_name_config }/config.hcl ${ vault_config_dir }/config.hcl
aws --region ${ region } s3 cp s3://${ bucket_name_config }/crt.pem    ${ vault_config_dir }/crt.pem
aws --region ${ region } s3 cp s3://${ bucket_name_config }/key.pem    ${ vault_config_dir }/key.pem

# Get My IP Address
MYIP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

# Add My IP Address as cluster_address in Vault Configuration
sed -i -e "s/MY_IP_SET_IN_USERDATA/$MYIP/g" ${ vault_config_dir }/config.hcl

# Start Vault now and on boot
systemctl enable vault
systemctl start vault
