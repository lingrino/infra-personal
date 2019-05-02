# Personal Infrastructure

This repo contains code (mostly terraform) for configuring all of my personal infrastructure in
code. If you're interested, the terraform modules inside of `terraform-modules` should be well
documented and usable on their own.

I have operated versions of this infrastructure at much larger scale and this repo should be laid
out in such a way that you can adapt it to your needs easily.

## Security

I take security very seriously. When done properly, this project should not present a secutiy risk
to my infrastructure. However, if you notice a vulnerability please email me at
security@lingrino.com

## Organization

The terraform in this repo is organized in a function-specific way. This means that the terraform is
separated primarily by the AWS account the the infra lives in, but also can be separated by specific
functions to be managed. For example, there is terraform at `terraform/aws/accounts/prod`, but also
at `terraform/aws/common/dns`. The first manages generic infrastructure in the account whereas the
second manages a specific thing (DNS) in a non-specific account (prod).

As infrastructure grows I've found this to be the most scalable solution. One major problem that
large terraform infrastructures encounter is the threading of outputs across many different
workspaces. This organization mitigates output and remote state usage because we can manage stacks
of infrastructure (such as dns or static sites) in separate self-contained workspaces.

A previous version of this repo managed terraform in a more resource-specific way. Meaning there
were terraform repos for `rds`, `vpc`, etc... This type of organization does not scale as you are
constantly threading outputs from `vpc` -> `rds` -> `ecs` -> `dns`. Instead these should all be
handled in a single module and called from a more generic workspace.

Another issue that terraform can encounter with scale is large workspaces that manage too many
different things. For example, as the `prod` account here grows to thousands of resources it will
not be wise or easy to manage all of those resources in a single workspace. Instead expansion in
that way can be segmented in a new folder structure such as `terraform/aws/apps` and
`terraform/aws/sites` (for example). This lets you be as granular as needed while still keeping
output management to a minimum.

This repo also managed some of my non-aws infrastructure like my GitHub and TLS repos. Terraform is
a great tool for these purposes as well.

## Using this Repo

Everything in this repo is MIT Licensed and free for you to use. Keep in mind that the modules are
generic but may still need customization before they work for you. For example, I do not add feature
flags to configurations I do not intend on using. The modules generally enforce very strict best
practices and security requirements (https, ipv6, etc...)

Also you should not depend on these modules always existing in this location or on any kind of
versioning or compatibility guarantees. If you need reassurance that the module will continue to
work for you then you should fork it and merge upstream changes in after you test new functionality.

## References to Modules

You will notice that this repo uses *relative* references to modules instead of git references
(`../../module//` instead of `git@module.get`). This is very beneficial from a speed of development
perspective. Since all callers of the module are in the same repo as the modules themselves my
changes can incorporate both and local testing will work without any pushes to the repo and changes
to branches in the module source. However, in a serious production infrastructure you should
consider referencing modules back to a git/package repo and make sure that you reference specific
versions of modules.

## Things to Add

There's a lot more that can be added to this repo, here's a list of what I have planned. Keep in
mind that this infrastructure is funded by an individual, so cost is a major concern. This means
modules that are expensive (`vpc`, `config`) will work but may not be in use because of their cost.

- [ ] Automated plan/apply CI/CD using Atlantis
- [ ] Automated linting of terraform and README
- [ ] Well documented modules
- [ ] Updates to work with terraform 0.12
- [ ] Account base module should remove default vpcs
- [ ] VPC module should tag the default security groups
- [ ] Module for cross account domain delegation
- [ ] Add dev.domain.com for all domains to dev account
- [ ] Add module to create a static landing page (or redirect) for all unused domains
- [ ] Static site module should create cloudwatch alarms
- [ ] SNS topic that notifies my email in every account
- [ ] Module that adds rouet53 healthchecks and alarms
- [ ] DNS query logging to cloudwatch
- [ ] Cloudtrail logs to cloudwatch
- [ ] Budgets for AWS bill
- [ ] ACM module for same account and cross account usage
