# AWS IaC Pipeline Showcase

A public-safe reference implementation of a GitHub Actions → Terraform → AWS delivery pipeline.

This repository demonstrates the architecture and security decisions behind a real infrastructure pipeline without publishing private account identifiers, state locations, organization details, or operational history.

## What it demonstrates

- GitHub Actions authentication to AWS through OIDC—no long-lived AWS keys
- Separate roles for pull-request plans and protected applies
- Remote Terraform state with encryption, versioning, and locking
- Path-scoped validation and deployment workflows
- A manual approval boundary for higher-impact changes
- Public-repository safety controls and a practical threat model

```text
Pull request ──> fmt + validate ──> read-only AWS role ──> terraform plan
                                                        │
Merge to main ──> manual dispatch ──> protected environment approval
                                      │
                                      └──> apply AWS role ──> terraform apply
```

## Repository layout

| Path | Purpose |
|---|---|
| `bootstrap/` | One-time state backend and GitHub OIDC roles |
| `environments/example/` | Sanitized example workload |
| `.github/workflows/` | Offline validation and AWS plan/apply pipelines |
| `docs/threat-model.md` | Trust boundaries and public-repo considerations |

## Quick start

1. Fork or copy this repository.
2. Replace `example-owner` and `example-repository` in a `terraform.tfvars` file; never commit real account-specific values.
3. Run the bootstrap locally with trusted AWS credentials.
4. Store the bootstrap outputs as GitHub repository variables:
   - `AWS_REGION`
   - `TF_STATE_BUCKET`
   - `TF_LOCK_TABLE`
   - `TF_PLAN_ROLE_ARN`
   - `TF_APPLY_ROLE_ARN`
5. Create a GitHub Environment named `production-apply` and require reviewers.
6. Open a pull request to exercise validation and the read-only plan path.
7. After merge, manually dispatch the apply workflow.

See [SECURITY.md](SECURITY.md) and [the threat model](docs/threat-model.md) before adapting this pattern.

## Important

This is an educational reference, not a turnkey production deployment. Review IAM permissions, state access, branch protection, environment reviewers, action pinning, and Terraform plans for your own threat model.

## License

MIT
