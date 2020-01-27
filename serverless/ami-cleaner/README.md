# Serverless - AMI Cleaner

This lambda function, defined in `serverless.yml`, cleans up unused AMIs using the [cami](https://github.com/lingrino/cami) package.

## Deployment

The function is deployed in the dev, prod, and audit accounts, where the AMIs may exist. Authenticate as each account and run `make deploy` to update

## Improvements

Currently we only run the AMI cleanup check in our region, `us-east-1`. We may want to contribute to cami to support all regions or deploy this function in each region to keep things cleaner.
