# Authentication Baseline

## Business Objective
The company needs a practical authentication baseline that reduces account compromise risk without disrupting normal work.

## Design Decisions
- Pilot MFA before expanding to all employees.
- Use a dedicated pilot group to control rollout.
- Keep emergency access accounts outside standard Conditional Access enforcement.
- Use Microsoft Authenticator as the preferred method.
- Allow a backup recovery-friendly method for pilot users where needed.
- Enable self-service password reset for the same pilot users.

## Business Reasoning
A phased rollout lowers implementation risk. Requiring stronger authentication too broadly on day one can create help desk spikes, user confusion, and accidental lockouts. A pilot-first approach proves the design before organization-wide expansion.

## Expected Outcomes
- Pilot users register security information
- Pilot users become eligible for MFA enforcement
- Pilot users can self-reset passwords
- Emergency accounts remain available for tenant recovery
