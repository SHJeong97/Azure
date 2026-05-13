$Domain = "summitridge-mfg.com"

$MxRecords = Resolve-DnsName $Domain -Type MX -ErrorAction SilentlyContinue
$SpfRecords = Resolve-DnsName $Domain -Type TXT -ErrorAction SilentlyContinue |
Where-Object { $_.Strings -match "v=spf1" }

$DmarcRecords = Resolve-DnsName "_dmarc.$Domain" -Type TXT -ErrorAction SilentlyContinue
$AutodiscoverRecord = Resolve-DnsName "autodiscover.$Domain" -Type CNAME -ErrorAction SilentlyContinue

$MailFlowDnsReadiness = @(
    [PSCustomObject]@{
        Record = "MX"
        Name = "@"
        Found = if ($MxRecords) { "Yes" } else { "No" }
        Status = if ($MxRecords) { "MX exists for inbound mail routing" } else { "Missing" }
    }
    [PSCustomObject]@{
        Record = "SPF"
        Name = "@"
        Found = if ($SpfRecords) { "Yes" } else { "No" }
        Status = if (($SpfRecords | Measure-Object).Count -eq 1) { "Single SPF record found" } else { "Review required" }
    }
    [PSCustomObject]@{
        Record = "DMARC"
        Name = "_dmarc"
        Found = if ($DmarcRecords) { "Yes" } else { "No" }
        Status = if ($DmarcRecords) { "DMARC monitoring record found" } else { "Missing" }
    }
    [PSCustomObject]@{
        Record = "Autodiscover"
        Name = "autodiscover"
        Found = if ($AutodiscoverRecord) { "Yes" } else { "No" }
        Status = if ($AutodiscoverRecord) { "Autodiscover exists for Outlook/client discovery" } else { "Missing" }
    }
)

$MailFlowDnsReadiness
