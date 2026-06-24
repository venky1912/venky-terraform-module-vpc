# Changelog

## [0.1.1](https://github.com/venky1912/venky-terraform-module-vpc/compare/v0.1.0...v0.1.1) (2026-06-24)


### Bug Fixes

* add trivyignore for intentional public subnet config ([a3ec624](https://github.com/venky1912/venky-terraform-module-vpc/commit/a3ec624764a9e0afa3a206e5246d910a64a0fa4b))
* align terraform-docs version in CI to v0.24.0 ([f7d30f6](https://github.com/venky1912/venky-terraform-module-vpc/commit/f7d30f6e239fd1f359308ff6a9bbb3e3fca824bf))
* remove trivy-action due to supply chain compromise, use Checkov only ([046f5d6](https://github.com/venky1912/venky-terraform-module-vpc/commit/046f5d6b259da25d19b392a7865c7f77230d7db3))
* resolve all CI pipeline failures ([0e5be4f](https://github.com/venky1912/venky-terraform-module-vpc/commit/0e5be4fa30a0f3f06616393e5e7bf410424786f3))
* resolve all deprecated actions and CI failures ([3645b53](https://github.com/venky1912/venky-terraform-module-vpc/commit/3645b53751db44bdf401d78c5de392d166e77b99))
* resolve Checkov security findings ([a0af473](https://github.com/venky1912/venky-terraform-module-vpc/commit/a0af473db600a59dc0f8dd53288c6fcf917dec7a))
* resolve remaining Checkov findings and update to Node 24 actions ([1da5df3](https://github.com/venky1912/venky-terraform-module-vpc/commit/1da5df357d51cb95f7b7063f19cf5534b5831298))
* skip CKV2_AWS_5 false positive for conditional SG attachment ([b37c407](https://github.com/venky1912/venky-terraform-module-vpc/commit/b37c4077e220bdfab3bf7b489e29ac03bb76da96))
* skip intentional Checkov findings for VPC module ([f571bd1](https://github.com/venky1912/venky-terraform-module-vpc/commit/f571bd17587548ac13b0e44eef6db54608e1a7fd))
* trigger release pipeline ([93dae2a](https://github.com/venky1912/venky-terraform-module-vpc/commit/93dae2a8b150b737ad776c27eddef1e00129d0fa))
* update to non-deprecated action versions ([9ddec9f](https://github.com/venky1912/venky-terraform-module-vpc/commit/9ddec9f653061538a84399af1fc2ab0504a15af0))
* use non-deprecated action versions ([ef39863](https://github.com/venky1912/venky-terraform-module-vpc/commit/ef39863e0ea08549fa541aeef236464757e10d67))

## [0.1.0] - 2026-06-24

### Added

- Initial release
- Multi-AZ VPC with public, private, and database subnets
- NAT Gateway (single or per-AZ)
- Internet Gateway
- VPC Gateway endpoints (S3, DynamoDB)
- VPC Interface endpoints (configurable)
- VPC Flow Logs to CloudWatch
- Secondary CIDR block support
- EKS-ready subnet tagging support
