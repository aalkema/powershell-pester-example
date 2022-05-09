# powershell-pester-example
A small example of using Pester to write unit tests for Powershell.

Cases covered in this example:

* Simple case - testing code with no external dependencies - see Tests/Get-InstancesThatMatchExpression.tests.ps1.  

* Mocking a method that returns data - Tests/Get-EC2InstanceNames.Tests.ps1

* Stubbing out a command and checking to confirm it was called with the expected parameters - Tests/Remove-InstanceByName.Tests.ps1
