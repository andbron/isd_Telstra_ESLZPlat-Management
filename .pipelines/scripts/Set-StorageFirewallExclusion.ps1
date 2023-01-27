<#
.SYNOPSIS
Set (by mode: ON OFF) the Storage Account Firewall Rules by Public IP address. Used by Azure DevOps Build/Release agents
See here : https://github.com/terraform-providers/terraform-provider-azurerm/issues/2977
.DESCRIPTION
Using Azure CLI
.EXAMPLE
.\SetMode_PublicIPAddress_SA.ps1 -storageaccount sa12345random -resourcegroup RG-NDM-TEST -mode on
.NOTES
Written by Andrew Lambert- Jan 2023
#>
param (
	[Parameter(Mandatory=$true)]
	[string]$storageaccount,
	[Parameter(Mandatory=$true)]
        [string]$resourcegroup,
        [Parameter(Mandatory=$true)]
	[string]$mode
)
#
$ip = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip
write-host $ip
#
if ($mode -eq 'on') { 
az storage account network-rule add --resource-group $resourcegroup --account-name $storageaccount --ip-address $ip
} 
#
if ($mode -eq 'off') {
az storage account network-rule remove --resource-group $resourcegroup --account-name $storageaccount --ip-address $ip
}