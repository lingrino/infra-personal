#!/usr/bin/env bash

# This script tags ALL default RDS db security groups in an AWS account
# Used to keep them from being noncompliant in AWS config

# Assume a role that can remove the SGs
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

    sg=$(aws --region "${region}" rds describe-db-security-groups --db-security-group-name default | jq -r '.[] | .[0] | .DBSecurityGroupArn')

    if [ "${sg}" = "null" ]; then
        echo "No default sg found in ${region}"
        echo ""
        continue
    fi
    echo "Found Default SG: ${sg}"

    echo "Tagging Default SG: ${sg}"
    aws rds --region "${region}" add-tags-to-resource --resource-name "${sg}" --tags Key=Name,Value=DO_NOT_USE --tags Key=service,Value=rds

    echo "Tagged default SG in ${region}"
    echo ""
done
