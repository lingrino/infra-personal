# AWS V2

IDEAS:

3 Accounts:

- Root/shared
  - Contains remote state
  - Would container other shared resources
- Auth (where users log in)
- Audit (contains buckets for logging)
  - Flow Logs
  - LB Logs
  - DNS Logs
  - Cloudtrail Logs
  - Config Logs
  - S3 Logs
- Dev
  - Test things here
- Prod
  - Contains my infra
