<#
.SYNOPSIS
Starts or stops all VMs in a specified resource group.

.PARAMETER Action
Accepted values: Start, Stop

.PARAMETER ResourceGroup
Target resource group name

.AUTHOR
Rahul Chamoli
#>

param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("Start", "Stop")]
    [string]$Action,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroup
)

if (-not (Get-AzContext)) {
    Connect-AzAccount
}

$vms = Get-AzVM -ResourceGroupName $ResourceGroup

foreach ($vm in $vms) {
    if ($Action -eq "Start") {
        Start-AzVM -Name $vm.Name -ResourceGroupName $ResourceGroup
        Write-Host "🚀 Started VM: $($vm.Name)"
    }
    elseif ($Action -eq "Stop") {
        Stop-AzVM -Name $vm.Name -ResourceGroupName $ResourceGroup -Force
        Write-Host "🛑 Stopped VM: $($vm.Name)"
    }
}
