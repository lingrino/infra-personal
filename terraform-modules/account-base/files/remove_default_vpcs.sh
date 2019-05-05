#!/usr/bin/env bash

# This script deletes ALL default VPCs in an AWS account
# Based On: https://gist.github.com/jokeru/e4a25bbd95080cfd00edf1fa67b06996

# Assume a role that can remove the VPCs
# This script assumes your main provider can assume `OrganizationAccountAccessRole` in all accounts
CREDS=$(aws sts assume-role --role-arn "arn:aws:iam::${ACCOUNT_ID}:role/OrganizationAccountAccessRole" --role-session-name vpc-remover | jq -r '.Credentials')
akid=$(echo "$CREDS" | jq -r '.AccessKeyId')
sak=$(echo "$CREDS" | jq -r '.SecretAccessKey')
st=$(echo "$CREDS" | jq -r '.SessionToken')
export AWS_ACCESS_KEY_ID="$akid"
export AWS_SECRET_ACCESS_KEY="$sak"
export AWS_SESSION_TOKEN="$st"
export AWS_SECURITY_TOKEN="$st"

for region in $(aws ec2 describe-regions --region us-east-1 | jq -r '.Regions[].RegionName'); do
  echo "--------- REGION: ${region} ---------"

  vpc=$(aws ec2 --region "${region}" describe-vpcs --filter Name=isDefault,Values=true | jq -r '.Vpcs[0].VpcId')
  if [ "${vpc}" = "null" ]; then
    echo "No default VPC found in ${region}"
    echo ""
    continue
  fi
  echo "Found Default VPC: ${vpc}"
  dhcp=$(aws ec2 --region "${region}" describe-vpcs --filter Name=isDefault,Values=true | jq -r '.Vpcs[0].DhcpOptionsId')

  igw=$(aws ec2 --region "${region}" describe-internet-gateways --filter Name=attachment.vpc-id,Values="${vpc}" | jq -r '.InternetGateways[0].InternetGatewayId')
  if [ "${igw}" != "null" ]; then
    echo "Removing Internet Gateway: ${igw}"
    aws ec2 --region "${region}" detach-internet-gateway --internet-gateway-id "${igw}" --vpc-id "${vpc}"
    aws ec2 --region "${region}" delete-internet-gateway --internet-gateway-id "${igw}"
  fi

  subnets=$(aws ec2 --region "${region}" describe-subnets --filters Name=vpc-id,Values="${vpc}" | jq -r '.Subnets[].SubnetId')
  if [ "${subnets}" != "null" ]; then
    for subnet in ${subnets}; do
      echo "Removing Subnet: ${subnet}"
      aws ec2 --region "${region}" delete-subnet --subnet-id "${subnet}"
    done
  fi

  echo "Removing Default VPC: ${vpc}"
  aws ec2 --region "${region}" delete-vpc --vpc-id "${vpc}"

  if [ "${dhcp}" != "null" ]; then
    echo "Removing DHCP Options: ${dhcp}"
    aws ec2 --region "${region}" delete-dhcp-options --dhcp-options-id "${dhcp}"
  fi

  echo "Removed default VPC and resources in ${region}"
  echo ""
done
