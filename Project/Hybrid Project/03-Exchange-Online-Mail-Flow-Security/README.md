# Exchange Online Administration and Mail Flow Security for a 75-User Company

## Introduction

This project simulates a 75-user company improving its Exchange Online administration and mail-flow security baseline by building shared mailbox standards, transport rules, and Defender mail hygiene policies.

The project reused the existing Microsoft 365 tenant and hybrid identity foundation from earlier work, then focused on a realistic Microsoft 365 administration problem: how to standardize shared mailbox operations, improve visibility of risky external email, and create a more defensible mail security baseline.

This project intentionally combines:
- Exchange Online recipient administration
- mail flow rules
- Microsoft Defender anti-phishing and anti-spam controls
- evidence-based validation through observable mailbox outcomes

## Objectives

- Create and standardize shared mailboxes for business departments
- Document and validate shared mailbox access design
- Implement mail flow rules for external subject tagging, warnings, and executable attachment blocking
- Create custom anti-phishing and anti-spam policies in Microsoft Defender
- Review default anti-malware coverage
- Validate observed delivery, warning, and rejection behavior
- Tie mail administration decisions to business risk and operational value

## Full Implementation

### 1. Shared mailbox design
- Planned shared mailboxes for:
  - HR
  - Finance
  - Operations
- Mapped department users to the appropriate mailbox access paths
- Configured Sent Items behavior for better shared-mailbox visibility

### 2. Shared mailbox creation
- Created:
  - `hr@democompany1016.onmicrosoft.com`
  - `finance@democompany1016.onmicrosoft.com`
  - `operations@democompany1016.onmicrosoft.com`
- Added department-specific members
- Documented mailbox delegation model

### 3. Mail flow rule baseline
- Created `MF01-Tag-External-Inbound-Mail`
- Created `MF02-Warn-External-Mail-To-Shared-Mailboxes`
- Created `MF03-Block-Inbound-Executable-Attachments`
- Reviewed rule ordering and enabled state

### 4. Defender policy baseline
- Created `DP01-Exec-SharedMailbox-AntiPhish`
- Created `DP02-SharedMailbox-Inbound-AntiSpam`
- Reviewed and retained the default anti-malware policy
- Scoped custom policies to executive and shared-mailbox business paths

### 5. Validation approach
- Sent external test messages
- Confirmed `[External]` subject-tag behavior
- Confirmed shared mailbox disclaimer behavior
- Attempted spam/quarantine and rejection validation
- Documented lab limits honestly where full verification was not captured

## Implementation Walkthrough

### Design choices
The project reused the existing Microsoft 365 and hybrid identity foundation so that the work could focus on Exchange administration instead of rebuilding user identity.

Shared mailboxes were selected for HR, Finance, and Operations because these are common department-level functional identities that should outlive any one individual user account.

Mail flow rules were implemented before deeper Defender tuning because visible transport controls provide immediate business value and easy-to-explain validation evidence.

### Security choices
External subject tagging was implemented to reduce the chance that users mistake external mail for trusted internal communication.

A shared-mailbox disclaimer rule was added because Finance, HR, and Operations are higher-risk communication paths for phishing, fraud, and sensitive-data requests.

Inbound executable attachment blocking was used as a transport-level reduction of obvious high-risk content.

Custom anti-phishing and anti-spam policies were then added in Defender to strengthen shared-mailbox and executive-facing mail paths.

### Validation choices
Validation focused on real observable outcomes rather than just screenshots of settings pages. The project captured mailbox results, visible warnings, and test-message outcomes. Where quarantine or message trace evidence was not fully captured in the lab run, that limitation was documented honestly instead of overstating results.

## Results & Validation

### Shared mailbox results
- Shared mailboxes were created successfully
- Department-based mailbox access design was implemented
- Shared mailbox Sent Items handling was configured

### Mail flow results
- External inbound messages showed `[External]` in the subject
- Shared mailbox disclaimer behavior was observed
- Executable attachment blocking was configured and tested

### Defender results
- Custom anti-phishing policy was created successfully
- Custom inbound anti-spam policy was created successfully
- Default anti-malware policy was reviewed and retained

### Validation results
- Observable transport-rule outcomes were confirmed
- Spam-like mail to Finance was delivered with transport warning behavior
- Quarantine behavior was not conclusively verified in the lab run
- Message trace evidence was not fully captured in the lab run

## Validation Walkthrough

### Key validation checks performed
- Reviewed shared mailbox configuration
- Observed external subject-tag behavior in inbox
- Observed disclaimer behavior in shared mailbox
- Attempted executable attachment block validation
- Reviewed Defender quarantine during lab validation
- Attempted message trace validation
- Documented actual observed outcomes instead of assumed outcomes

### Evidence locations
- Business scenario: `docs/01-business-scenario.md`
- Mail hygiene baseline: `docs/07-mail-hygiene-baseline.md`
- Policy scope: `docs/08-defender-policy-scope.md`
- Validation scenarios: `docs/09-validation-scenarios.md`
- Message trace plan: `docs/10-message-trace-plan.md`
- Final validation summary: `docs/11-final-validation-summary.md`
- Evidence index: `evidence/evidence-index.md`

## Key Takeaways

- Exchange administration should be tied to business mail paths, not only mailbox creation tasks
- Shared mailboxes need clear access design and operational visibility
- Transport rules provide immediate visible risk reduction for external email
- Defender policies add a second layer of protection beyond transport rules
- Observable inbox outcomes are useful evidence, but not the same as full quarantine or trace proof
- Honest documentation of lab limits strengthens the project more than overstating security validation
