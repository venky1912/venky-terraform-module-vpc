# Branch Protection Rules

Configure these on GitHub under Settings → Branches → Branch protection rules for `main`:

## Required Settings

- [x] Require a pull request before merging
- [x] Require approvals: 1
- [x] Require status checks to pass before merging:
  - `CI Passed`
- [x] Require branches to be up to date before merging
- [x] Require conversation resolution before merging
- [x] Require linear history (squash merge only)
- [x] Do not allow bypassing the above settings

## PR Title Convention (Conventional Commits)

All PR titles must follow this format:

```
<type>: <description>
```

Allowed types:
- `feat` — new feature (triggers MINOR version bump)
- `fix` — bug fix (triggers PATCH version bump)
- `docs` — documentation only
- `chore` — maintenance (no version bump)
- `refactor` — code refactoring
- `test` — test changes
- `ci` — CI/CD changes
- `perf` — performance improvement
- `revert` — revert a previous commit
- `breaking` — breaking change (triggers MAJOR version bump)

Examples:
- `feat: add transit gateway attachment support`
- `fix: correct NAT gateway AZ assignment`
- `docs: update usage example for EKS`
