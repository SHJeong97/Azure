# Cost Control Plan

## Budget Limit

The lab budget limit is $100.

## Cost-Control Strategy

This portfolio uses a cost-controlled Azure lab design. The environment will use low-cost VM sizes, scheduled shutdown, small test data sets, and limited paid security features.

## Required Controls

### 1. Azure Budget Alerts

Create a monthly Azure budget with alert thresholds at:

- 50%
- 75%
- 90%
- 100%

### 2. VM Runtime Control

All lab VMs must be stopped and deallocated when not actively used.

### 3. VM Size Control

Use low-cost burstable VM sizes where possible.

### 4. Storage Control

Use Standard HDD or Standard SSD for lab servers unless a specific project requires otherwise.

### 5. Defender for Cloud Control

Do not enable paid Defender for Cloud plans until the dedicated security-hardening project.

### 6. Network Cost Control

Do not deploy Azure Firewall, VPN Gateway, ExpressRoute, NAT Gateway, or Load Balancer unless a project specifically requires it.

### 7. Storage Modernization Control

For Azure Files testing, use small test files only. Avoid Premium Azure Files.

## Risk

Without budget alerts and VM shutdown discipline, the lab can exceed the intended $100 budget.

## Risk Treatment

Reduce the risk by using Azure budget alerts, VM auto-shutdown, manual deallocation, and periodic cost review.

## Business Value

Cost control demonstrates FinOps awareness and shows that infrastructure decisions must balance technical value with financial responsibility.
