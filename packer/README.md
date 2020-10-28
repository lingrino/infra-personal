# Packer

This folder contains the packer for the images that I run. Packer is switching to HCL format and I will switch to that as soon as it's ready. The current `server.pkr.hcl` is out of date until HCL format supports the features I need.

## Building

Images are built in CI on changes in main and every Monday morning. I don't share images across accounts because I use [cami](https://github.com/lingrino/cami) which removes images that are not used in the account.

Build images with the following commands

```shell
# Build all images, must be authenticated already
> packer build infra.pkr.hcl

# Build only the AWS Images
> packer build -only 'amazon-ebs.*' infra.pkr.hcl
```

## Docker Based Images

Docker based versions of each image are also provided to make building locally faster when validating changes.
