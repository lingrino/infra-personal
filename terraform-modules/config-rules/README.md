# Module - Config Rules

This module creates a standard set of AWS config rules that enforce a strict set
of best practices (encrypted storage, tagged resources, non-public resources).

These rules are set up such that they should not require any inputs or customization
from the consumer. All of these rules should be general enough on their own, and
any user of this module can always add their own rules on top.

## Usage Requirements

This module requires that you already have an AWS config recorded set up. The module
does not do that for you because it can be done in many different ways and becacuse
for some it is useful to have config recording enabled independent of any rules on
top of AWS config.

## Tagging Policy

The tagging policy enforced in `rules_tagging.tf` is relatively light. It requires
that every resource have a `Name` and `service` tag and a k/v tag of `terraform=true`.
If you would like to enforce additional tags or remove these requireements simply
fork the module and make your own changes.

## Modifying this Module

The module is intentionally opinionated (there are no conditionals). If some of these
config rules are not suited to your AWS environment you can fork the module and add or
remove rules that work better for your specific use case.

I am also open to adding conditional creation of certain rules in this module, so long
as it is not burdensome and all rules are created by default.
