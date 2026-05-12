# Project 03 Batch 8
# Validate SPF, DKIM, and DMARC public DNS records for summitridge-mfg.com.

$Domain = "summitridge-mfg.com"
$EvidencePath = "C:\LabEvidence\Project03\Batch08"

New-Item -ItemType Directory -Path $EvidencePath -Force | Out-Null

$TxtRecords = Resolve-DnsName $Domain -Type TXT -ErrorAction SilentlyContinue
$SpfRecords = $TxtRecords | Where-Object { $_.Strings -match "v=spf1" }

$DmarcRecords = Resolve-DnsName "_dmarc.$Domain" -Type TXT -ErrorAction SilentlyContinue
$Selector1 = Resolve-DnsName "selector1._domainkey.$Domain" -Type CNAME -ErrorAction SilentlyContinue
$Selector2 = Resolve-DnsName "selector2._domainkey.$Domain" -Type CNAME -ErrorAction SilentlyContinue

$Summary = [PSCustomObject]@{
    Domain = $Domain
    SPFRecordCount = ($SpfRecords | Measure-Object).Count
    SPFStatus = if (($SpfRecords | Measure-Object).Count -eq 1) { "Valid single SPF record found" } else { "Review required" }
    DMARCRecordFound = if ($DmarcRecords) { "Yes" } else { "No" }
    DKIMSelector1Found = if ($Selector1) { "Yes" } else { "No" }
    DKIMSelector2Found = if ($Selector2) { "Yes" } else { "No" }
    RecommendedDMARCPolicyAtThisStage = "p=none"
}

$TxtRecords |
Out-File "$EvidencePath\script-output-email-authentication-txt-records.txt"

$DmarcRecords |
Out-File "$EvidencePath\script-output-email-authentication-dmarc-record.txt"

$Selector1 |
Out-File "$EvidencePath\script-output-email-authentication-dkim-selector1.txt"

$Selector2 |
Out-File "$EvidencePath\script-output-email-authentication-dkim-selector2.txt"

$Summary |
Export-Csv "$EvidencePath\script-output-email-authentication-summary.csv" -NoTypeInformation

$Summary