# Module - Account Base

This module configures all of the *base* resources in an account. These are
resources that *every* account in the organization should have, without
exceptions. For example, here we create predefined roles that can be assumed,
password policies, and the account alias.s

## What Belongs in this Module

The only resources that belong in this account are ones that will be created
in every account in the organization. There should be no conditional creation
of resources in this module. This is a great modules to put base account
resources that are required for initial access and organization.
