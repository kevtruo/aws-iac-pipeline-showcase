# Security policy

## Reporting

Please do not open a public issue for a suspected vulnerability. Use GitHub's private vulnerability reporting feature when enabled.

## Public-repository rules

Never commit:

- AWS account IDs, organization IDs, real ARNs, or state bucket/table names
- Terraform state, saved plans, credentials, webhook URLs, or private endpoints
- production variable files or copied output from deployed infrastructure
- internal repository names, incident details, or private commit history

Before publishing a change:

1. Run `terraform fmt -check -recursive`.
2. Run `terraform init -backend=false` and `terraform validate` in each root.
3. Inspect the complete diff.
4. Scan the working tree and Git history for secrets and identifiers.
5. Review the plan's exact add/change/destroy counts before any apply.

A clean current tree does not erase a secret from Git history. Rotate exposed credentials and rewrite history when necessary.
