
Import-Module AWS.Tools.EC2
function Get-EC2InstanceNames {
    param(
        [parameter(Mandatory = $true)][string]$Region
    )

    $instances = Get-EC2Instance -Region $Region
    return $instances.Instances.Tags | ? { $_.Key -eq "Name" } | Select Value
}

function Get-InstancesThatMatchExpression {
    param(
        [parameter(Mandatory = $true)][array]$InstanceNames,
        [parameter(Mandatory = $false)][string]$RegEx = ""
    )

    $InstancesThatMatch = @()

    foreach ($instance in $InstanceNames) {
        if ($instance -match $RegEx) {
            $InstancesThatMatch += $instance
        }
    }

    return $InstancesThatMatch
}

function Remove-InstanceByName {
    param(
        [parameter(Mandatory = $true)][array]$Region,
        [parameter(Mandatory = $false)][string]$InstanceName
    )

    $instance = Get-EC2Instance `
        -Region $Region `
        -Filter @( @{name='tag:Name'; values=$InstanceName})
    if ($instance) {
        Remove-Ec2Instance `
        -Region $Region `
        -InstanceId $instance.Instances.InstanceId
    }    

}

Export-ModuleMember -Function `
    Get-EC2InstanceNames, `
    Get-InstancesThatMatchExpression, `
    Remove-InstanceByName