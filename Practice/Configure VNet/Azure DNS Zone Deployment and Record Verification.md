# Azure DNS Zone Deployment and Record Verification

## Introduction

In this project, I deployed a custom DNS zone using Azure DNS and created an A record to map a hostname to an IP address. After configuring the DNS record, I validated the configuration using the `nslookup` tool through Azure Cloud Shell.

Azure DNS provides globally distributed name resolution services that allow cloud resources and applications to be accessed using human-readable domain names rather than IP addresses.

This project demonstrates how DNS zones are created, how DNS records are configured, and how DNS resolution can be validated within Azure infrastructure.

---

## Objectives

- Deploy a DNS zone in Azure DNS
- Configure an A record for a web host
- Understand name server delegation
- Validate DNS resolution using `nslookup`
- Verify DNS functionality using Azure Cloud Shell

---

## Full Implementation

### Create Azure DNS Zone

#### Azure CLI (Bash)

```bash
az network dns zone create \
  --resource-group <resource-group-name> \
  --name exampledemo.com
``` 
#### Azure PowerShell
```powershell
New-AzDnsZone `
 -Name "exampledemo.com" `
 -ResourceGroupName "<resource-group-name>"
``` 

### Create DNS A Record
#### Azure CLI (Bash)
```bash
az network dns record-set a add-record \
 --resource-group <resource-group-name> \
 --zone-name exampledemo.com \
 --record-set-name www \
 --ipv4-address 10.10.10.10
``` 
#### Azure PowerShell
```powershell
Add-AzDnsRecordConfig `
 -RecordSetName "www" `
 -ZoneName "exampledemo.com" `
 -ResourceGroupName "<resource-group-name>" `
 -Ipv4Address "10.10.10.10"

Set-AzDnsRecordSet `
 -RecordSetName "www" `
 -ZoneName "exampledemo.com" `
 -ResourceGroupName "<resource-group-name>"
``` 
Configuration Summary:
- DNS Zone: exampledemo.com


- Record Type: A


- Hostname: www


- TTL: 1 hour


- Target IP: 10.10.10.10



##  Implementation Walkthrough
### Step 1 – DNS Zone Creation
A DNS zone was created in Azure DNS to manage domain records.
Key configuration:
- Zone Name: exampledemo.com


- Resource Group: rg_eastus_XXXXX


- Global Azure DNS infrastructure used


Azure automatically assigns multiple authoritative Name Servers (NS) for the zone.
Example:
ns1-04.azure-dns.com
ns2-04.azure-dns.net
ns3-04.azure-dns.org
ns4-04.azure-dns.info
These name servers are responsible for resolving records in the DNS zone.
<img width="1336" height="1080" alt="image" src="https://github.com/user-attachments/assets/48c2f143-9cb9-4463-b2e9-d85bb878f885" />


### Step 2 – DNS Record Configuration
A DNS A record was created to map a hostname to an IPv4 address.
Record details:
| Field      | Value       |
| ---------- | ----------- |
| Name       | www         |
| Type       | A           |
| TTL        | 1 hour      |
| IP Address | 10.10.10.10 |


This creates the hostname:
www.exampledemo.com
which resolves to:
10.10.10.10
In real-world deployments, this IP would normally be:
- Public IP of a Web App


- Public IP of a VM


- Load balancer frontend IP

<img width="1523" height="627" alt="image" src="https://github.com/user-attachments/assets/f7b6fe69-dd44-44cb-8407-16077e8be4d3" />



### Step 3 – DNS Verification Using Cloud Shell
DNS resolution was validated using Azure Cloud Shell (Bash).
Command executed:
nslookup www.exampledemo.com ns1-04.azure-dns.com
This queries the authoritative Azure DNS name server directly.
<img width="1523" height="255" alt="image" src="https://github.com/user-attachments/assets/9bf6ea63-3253-4a2a-8090-7429dd158f74" />


##  Results & Validation
The nslookup command returned the configured IP address successfully.
Example output:
Name:    www.exampledemo.com
Address: 10.10.10.10
This confirms:
- DNS zone deployment successful


- DNS A record configured correctly


- Azure DNS name server responding properly


- Hostname resolution functioning



##  Validation Walkthrough
- Verified DNS zone creation in Azure Portal


- Confirmed DNS zone name servers were generated


- Created A record mapping hostname to IP


- Opened Azure Cloud Shell (Bash)


-Executed nslookup query against Azure DNS server


- Confirmed hostname resolved to configured IP


- Validated DNS configuration functioning correctly


All DNS functionality validated successfully.

##  Key Takeaways
- Azure DNS provides globally distributed authoritative DNS services.


- DNS zones store DNS records for a domain.


- A records map hostnames to IPv4 addresses.


- Azure automatically assigns multiple authoritative name servers.


- DNS resolution can be validated using nslookup.


- DNS configuration is essential for making cloud services accessible via domain names.


This project strengthens Azure Administrator skills in DNS infrastructure, domain resolution, and cloud networking fundamentals.



