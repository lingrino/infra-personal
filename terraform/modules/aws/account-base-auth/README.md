# Module - Account Base Auth

This is a special module whose purpose is to configure the "auth" (where users with log in)
account with core resources that are helpful for managing end user accounts.

The idea behind this module is that in an AWS multi account architecture you will generally
have one "auth" account where end users log in with a username and password. From this
account they will access all other accounts via assume role. So this module is intended to
create IAM groups and policies that allow users to manage themselves and to access other
accounts if they are allowed to.
