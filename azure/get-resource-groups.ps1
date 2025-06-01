<#
.SYNOPSIS
Lists all Azure Resource Groups in the current subscription.

.DESCRIPTION
Fetches and displays the name, location, and provisioning state of all resource groups.

.AUTHOR
Rahul Chamoli
#>

# Connect to Azure if not already connected
if (-not (Get-AzContext)) {
    Connect-AzAccount
}

# Get and display resource groups
Get-AzResourceGroup | Select-Object ResourceGroupName, Location, ProvisioningState | Format-Table -AutoSize
