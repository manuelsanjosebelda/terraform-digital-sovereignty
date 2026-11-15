# Technical Report: Terraform Digital Sovereignty & IaC Supply Chain Security

**Organisation:** ATUL0012345  
**Technologies:** Terraform, HashiCorp Sentinel, HCP Terraform, GitHub

## 1. Implementation & Testing Summary

I built a Policy-as-Code framework using Terraform and HashiCorp Sentinel to check AWS infrastructure configurations before deployment. The repository is connected to HCP Terraform through the `develop` branch, which automatically triggers plan runs and policy evaluations whenever changes are pushed.

Five Sentinel policies were implemented:

- **Digital Sovereignty (`sovereignty.sentinel`):** Restricts the AWS provider region to `eu-west-1` (Ireland).
- **Encryption & Metadata (`encryption.sentinel`):** Requires encrypted root EBS volumes and IMDSv2 (`http_tokens = "required"`).
- **Instance Types (`instance_type.sentinel`):** Only allows EC2 instance types `t3.micro` and `t3.small`.
- **Network Security (`network.sentinel`):** Prevents unrestricted inbound traffic, restricts SSH (port 22) to `10.0.0.0/8`, and allows HTTP traffic on port 80.
- **Supply Chain (`supply_chain.sentinel`):** Checks the AWS provider source, its approved version constraint (`~> 5.0`) and Terraform module sources against the configured requirements.

The `.terraform.lock.hcl` file records the selected AWS provider version (`5.100.0`) and its checksums. No external Terraform modules are currently used.

I chose **advisory** enforcement during development and testing so I could review the results of all five policies without interrupting the workflow. This made it easier to identify failures and test different configurations. In production, I would switch to **hard-mandatory** enforcement to prevent non-compliant runs from proceeding to the Apply stage.

All five local Sentinel test suites passed. In HCP Terraform, the compliant configuration passed all five policies. For the non-compliant test, I temporarily changed the EC2 instance type to `t3.large`, which caused the `approved-instance-types` policy to fail as expected. The other four policies passed. I then restored the original configuration.

No Apply operation was performed and no real AWS resources were created.

## 2. Final Limitations

Although the policies help identify configuration problems before deployment, there are some areas that would need further work:

- **Data Sovereignty:** Restricting the provider to `eu-west-1` does not guarantee that all data remains in Ireland. Backups, snapshots and logs may be replicated to other regions. The current policy also does not control administrative access or other legal jurisdictions.
- **Encryption Scope:** The encryption policy checks the root EBS volume and requires IMDSv2, but does not cover every possible additional EBS volume.
- **Supply Chain Security:** Sentinel checks the declared provider and module configuration, but cannot independently verify downloaded provider binaries, publisher signatures or dependency vulnerabilities.
- **Runtime Monitoring:** Sentinel evaluates Terraform runs. Changes made directly through the AWS Console will not be detected by these policies until another Terraform run takes place.
- **Maintenance:** AWS provider updates can change resource schemas and attributes. The policies will need to be reviewed and tested whenever the provider version is upgraded.

## 3. Recommendations for Production

Before using this setup in a live environment, I would focus on four improvements:

1. **Stronger Policy Enforcement:** Change the enforcement level from `advisory` to `hard-mandatory` so that non-compliant plans are blocked before Apply. A process for reviewing legitimate exceptions should also be established.
2. **Improved Data Sovereignty:** Extend the policies to cover S3 and RDS backup and replication settings, use customer-managed KMS keys in `eu-west-1`, and consider AWS Service Control Policies (SCPs).
3. **Continuous Monitoring:** Introduce AWS Config and scheduled Terraform drift detection to identify changes made outside the normal workflow.
4. **Supply Chain Protection:** Add tools such as Checkov or tfsec to GitHub Actions, verify signed provider releases where supported, and use immutable commit references for external Terraform modules.

## 4. Conclusion

This project gave me the opportunity to work with Terraform and HashiCorp Sentinel and understand how policy checks can be integrated into an infrastructure workflow.

The tests showed that the five policies worked as expected in the scenarios covered. The compliant plan passed all checks, while the non-compliant EC2 instance type was correctly identified by Sentinel.

There are still areas that would need improvement before using this setup in production, particularly around complete data residency, supply chain verification and continuous monitoring. However, the project provides a working starting point for introducing automated security checks before infrastructure changes are applied.
