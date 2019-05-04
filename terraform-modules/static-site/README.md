# Module - Static Site

This module creates a static site via an S3 bucket that is fronted by a cloudfront distribution. It
also creates an IAM user with limited permissions that can upload/deploy to the static site. This
module is very opinionated about the *right* way to set up a static site in AWS, by using
cloudfront, alias records, access identities, https redirects, and long cache TTLs.

This module also uses my [acm-certificate module][] to provision a certificate for all of the
domains passed in `${ var.dns_names_to_zone_names }`.

## Usage

The below code is a simple way of calling the module.

```terraform
module "site" {
  source = "../path/to/module/static-site//"

  name_prefix = "site"

  dns_names_to_zone_names {
    "example.com"     = "example.com"
    "*.example.com"   = "example.com"
    "foo.example.org" = "example.org"
  }

  tags = "${ var.tags }"
}
```

## The Default Index Page

By default, after applying this module, you will have a site where the content is simply whatever is
in the [files/index.html file][]. This file is specific to my own information. If you're interested
in using this module you should clone the repo and use your own content for `index.html`.
Alternatively after your first upload the `index.html` uploaded by this module will never appear again.

[acm-certificate module]: ../acm-certificate/README.md
[files/index.html file]: files/index.html

## Encryption

Note that this module requires that you upload content to the s3 bucket that is encrypted with AWS's
`AES256` algorithm.

## Access Logs

This module requires that you already have an S3 bucket set up that cloudfront can write access logs
to and that you are ok with a log prefix of `ACCOUNT_ID/NAME_PREFIX/`. You cannot disable logging
and you must pass `${ var.bucket_logs_domain }` to the module.

## Applying with CI/CD

This module is intended to be used for deploying to your site with CI/CD. The `deployer` user
created by this module has permissions to upload to the site's S3 bucket and to create cloudfront
invalidations on the created distribution.

Here's a GitLab CI/CD example that you can use to upload your own site

```yaml
image: python:3-alpine

stages:
  - publish

publish:
  stage: publish
  only:
    refs:
      - master
  script:
    - pip install awscli
    - aws --region us-east-1 s3 sync ./path/to/static/content/ "s3://${S3_BUCKET_NAME}" --sse AES256
    - aws cloudfront create-invalidation --distribution-id "${CF_DISTRIBUTION_ID}" --paths "/*"
```
