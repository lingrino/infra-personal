# Serverless - SNS Notifier

This lambda function, defined in `serverless.yml`, simply subscribes to SNS topics and emails the raw JSON message of those topics to me. This is a simple way of automating SNS -> email alerts for cloudwatch, SES bounces, and SES complaints.

## Deployment

The function is deployed in the audit account, where the SNS topics are. Simply authenticate as that account and run `make deploy`.
