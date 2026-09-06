# Threat model

## Assets

- AWS credentials obtained through GitHub OIDC
- Terraform state and lock data
- infrastructure controlled by Terraform
- workflow definitions and protected deployment environments

## Trust boundaries

### Pull requests

Pull requests run formatting and validation without cloud credentials. The optional AWS plan job uses a dedicated read-only role whose trust policy accepts only the repository's `pull_request` subject.

Public forks are untrusted input. Do not expose secrets to pull-request jobs, do not use `pull_request_target` to execute contributor code, and ensure the plan role cannot read unrelated secrets or mutate infrastructure.

### Applies

Apply is intentionally separate from pull-request execution. It requires:

- a manual workflow dispatch from `main`
- the GitHub Environment `production-apply`
- an environment-specific OIDC subject
- reviewer protection configured in GitHub
- a distinct AWS role with only the permissions required by the workload

### Terraform state

State can contain sensitive values even when configuration is sanitized. The state bucket is private, encrypted, versioned, and accessible only to explicitly authorized roles. State and saved plans are never uploaded as public workflow artifacts.

## Residual risks

- A compromised third-party action can access the job's permissions.
- Read-only AWS APIs can still disclose sensitive metadata.
- Overbroad IAM policies increase the impact of a workflow compromise.
- Reviewing source without reviewing the Terraform plan can miss destructive changes.

Pin actions to reviewed commit SHAs in a production implementation and use automated dependency update tooling to keep those pins current.
