[cmdletbinding()]
param (
    [parameter(Mandatory = $true)]
    [string]$DisplayName,

    [parameter(Mandatory = $true, ParameterSetName = "Root")]
    [parameter(Mandatory = $false, ParameterSetName = "Intermediate")]
    [System.IO.FileInfo]$RootCertificate,

    [parameter(Mandatory=$true, ParameterSetName = "Root")]
    [parameter(Mandatory=$false, ParameterSetName = "Intermediate")]
    [ValidateSet("ComputerRoot", "ComputerIntermediate", "UserIntermediate")]
    [string]$DestinationStore,

    
    [parameter(Mandatory = $true, ParameterSetName = "Intermediate")]
    [parameter(Mandatory = $false, ParameterSetName = "Root")]
    [System.IO.FileInfo]$IntermediateCertificate,

    [parameter(Mandatory=$true, ParameterSetName = "Intermediate")]
    [parameter(Mandatory=$false, ParameterSetName = "Root")]
    [ValidateSet("ComputerRoot", "ComputerIntermediate", "UserIntermediate")]
    [string]$IntermediateDestinationStore,

    [parameter(Mandatory = $true)]
    [string]$CertificateType
)

#region Authentication
$authParams = @{
    ClientId   = 'd1ddf0e4-d672-4dae-b554-9d5bdfd93547'
    DeviceCode = $true
}
$authRequest = ( Get-MsalToken @authParams )
$script:authHeader = @{ Authorization = $authRequest.CreateAuthorizationHeader() }
#endregion

#region Check the certificate type

#endregion