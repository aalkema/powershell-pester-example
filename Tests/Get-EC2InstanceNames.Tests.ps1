BeforeAll { 
    Remove-Module "EC2"
    Import-Module "$PSScriptRoot/../Modules/EC2.psm1"
}

Describe 'Get-EC2InstanceNames' {
    BeforeEach{
        Mock Get-EC2Instance -ModuleName EC2 {
            return @(
                @{
                    Instances = @{
                        InstanceId = "whocares";
                        Tags = @(
                            @{
                                Key = "Name";
                                Value = "Server1"
                            },
                            @{
                                Key = "SomethingElse";
                                Value = "nada"
                            }
                        )
                    };
                    Groups = @{}
                },
                @{
                    Instances = @{
                        InstanceId = "derek";
                        Tags = @(
                            @{
                                Key = "Name";
                                Value = "Computer2"
                            },
                            @{
                                Key = "SomethingElse";
                                Value = "nada"
                            }
                        )
                    };
                    Groups = @{}
                }
            )
        }
    }

    It 'Given instance objects should list only names' {
        $instances = Get-EC2InstanceNames `
            -Region "us-east-1"
        $instances.Count | Should -Be 2
    }
}