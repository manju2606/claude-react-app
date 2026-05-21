# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static React app deployed to AWS (S3 + CloudFront), provisioned with Terraform, and automated via GitHub Actions CI/CD.

## Commands

```bash
npm install          # install dependencies
npm start            # dev server at http://localhost:3000
npm run build        # production build → build/
npm test             # run tests in src/tests/ (watch=false in CI)
```

Run a single test file:
```bash
npm test -- --testPathPattern="App.test"
```

Terraform (from `terraform/` directory):
```bash
terraform fmt
terraform validate
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Architecture

Single-component React app (`src/App.js`) with no routing or state management. All content is static JSX.

**Test setup:** `src/App.test.js` is a leftover CRA scaffold with a stale assertion (`learn react`) that will fail — the canonical tests live in `src/tests/App.test.js`. The `npm test` script targets the `tests` directory explicitly to avoid running the root-level file.

**Infrastructure (`terraform/`):** provisions an S3 bucket (public access blocked) and a CloudFront distribution using Origin Access Control (OAC). Custom error responses on 403/404 return `index.html` for SPA routing support. Run `terraform output cloudfront_distribution_id` after apply to get the value needed for the CI/CD secret.

**CI/CD pipeline** (`.github/workflows/ci-cd.yml`): two jobs — `test-and-build` runs on all pushes/PRs; `deploy` runs only on pushes to `main`, syncs `build/` to S3 and invalidates the CloudFront cache. Required GitHub secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`, `S3_BUCKET_NAME`, `CLOUDFRONT_DISTRIBUTION_ID`.

## Terraform Conventions

- Copy `terraform/terraform.tfvars.example` → `terraform/terraform.tfvars` and set a globally unique `bucket_name` before running
- Never commit `terraform.tfvars` or state files (covered by `.gitignore`)
- Run `terraform fmt` before committing any `.tf` changes
- Every resource must have a `Project` tag

## Customization

The deployed-by details in `src/App.js` are intentionally left as placeholders:
```jsx
<h2>Deployed by: <strong>Your Full Name</strong></h2>
<p>Date: <strong>DD/MM/YYYY</strong></p>
```
Update these before deploying.
