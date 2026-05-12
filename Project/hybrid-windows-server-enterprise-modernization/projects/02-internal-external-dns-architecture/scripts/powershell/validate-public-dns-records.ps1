# Validate public DNS records for summitridge-mfg.com
# This script is for Project 03 after DNS records are published.

$Domain = "summitridge-mfg.com"

Write-Host "Checking TXT records for $Domain"
Resolve-DnsName -Name $Domain -Type TXT -ErrorAction SilentlyContinue

Write-Host "`nChecking MX records for $Domain"
Resolve-DnsName -Name $Domain -Type MX -ErrorAction SilentlyContinue

Write-Host "`nChecking SPF TXT record for $Domain"
Resolve-DnsName -Name $Domain -Type TXT -ErrorAction SilentlyContinue |
Where-Object { $_.Strings -match "spf" }

Write-Host "`nChecking Autodiscover CNAME"
Resolve-DnsName -Name "autodiscover.$Domain" -Type CNAME -ErrorAction SilentlyContinue

Write-Host "`nChecking DKIM selector 1"
Resolve-DnsName -Name "selector1._domainkey.$Domain" -Type CNAME -ErrorAction SilentlyContinue

Write-Host "`nChecking DKIM selector 2"
Resolve-DnsName -Name "selector2._domainkey.$Domain" -Type CNAME -ErrorAction SilentlyContinue

Write-Host "`nChecking DMARC TXT record"
Resolve-DnsName -Name "_dmarc.$Domain" -Type TXT -ErrorAction SilentlyContinue