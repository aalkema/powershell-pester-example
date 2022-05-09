BeforeAll { 
    Remove-Module "EC2"
    Import-Module "$PSScriptRoot/../Modules/EC2.psm1"
}

Describe 'Get-InstancesThatMatchExpression' {
    It 'Given no regex, should list all servers' {
        $instances = Get-InstancesThatMatchExpression `
            -InstanceNames @("Server1","Computer2","Machine3") `
            -RegEx ""
        $instances.Count | Should -Be 3
    }

    It "Given regex that doesn't match any, return none" {
        $instances = Get-InstancesThatMatchExpression `
            -InstanceNames @("Server1","Computer2","Machine3") `
            -RegEx "Box"
        $instances.Count | Should -Be 0
    }

    It "Given regex that matches one, return that one" {
        $instances = Get-InstancesThatMatchExpression `
            -InstanceNames @("Server1","Computer2","Machine3") `
            -RegEx "erv"
        $instances.Count | Should -Be 1
        $instances | Should -Be "Server1"
    }
}