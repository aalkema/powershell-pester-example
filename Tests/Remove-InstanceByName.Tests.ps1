BeforeAll { 
    Remove-Module "EC2"
    Import-Module "$PSScriptRoot/../Modules/EC2.psm1"
}

Describe 'Get-InstanceByName' {
    BeforeEach{
        Mock Remove-Ec2Instance -ModuleName EC2 {}

        Mock Get-EC2Instance -ModuleName EC2 {
            return @(
                @{
                    Instances = @{
                        InstanceId = "InstanceId1"
                    }
                }
            )
        } -ParameterFilter {$Filter.values -eq "Something"}

        Mock Get-EC2Instance -ModuleName EC2 {
            return @()
        } -ParameterFilter {$Filter.values -eq "NotReal"}
    }

    It 'Given a valid instance, calls remove' {
        Remove-InstanceByName `
            -Region "us-east-1" `
            -InstanceName "Something"
        Should -Invoke -CommandName Remove-Ec2Instance `
            -Times 1 `
            -ModuleName EC2 `
            -ParameterFilter {$InstanceId -eq "InstanceId1"}
    }

    It 'Given a nonexistent instance, does not remove' {
        Remove-InstanceByName `
            -Region "us-east-1" `
            -InstanceName "NotReal"
        Should -Invoke -CommandName Remove-Ec2Instance `
            -Times 0 `
            -ModuleName EC2
    }
}