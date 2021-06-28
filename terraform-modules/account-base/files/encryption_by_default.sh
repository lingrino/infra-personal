#!/usr/bin/env bash

# This script enables EBS encryption by default in all regions

# Assume a role that can enable encryption by default
# This script assumes your main provider can assume `OrganizationAccountAccessRole` in all accounts
CREDS=$(aws sts assume-role --role-arn "arn:aws:iam::${ACCOUNT_ID}:role/OrganizationAccountAccessRole" --role-session-name encryption-by-default | jq -r '.Credentials')
akid=$(echo "$CREDS" | jq -r '.AccessKeyId')
sak=$(echo "$CREDS" | jq -r '.SecretAccessKey')
st=$(echo "$CREDS" | jq -r '.SessionToken')
export AWS_ACCESS_KEY_ID="$akid"
export AWS_SECRET_ACCESS_KEY="$sak"
export AWS_SESSION_TOKEN="$st"
export AWS_SECURITY_TOKEN="$st"

for region in $(aws ec2 describe-regions --region us-east-1 | jq -r '.Regions[].RegionName'); do
    echo "--------- REGION: ${region} ---------"
    aws --region "${region}" ec2 enable-ebs-encryption-by-default
done
