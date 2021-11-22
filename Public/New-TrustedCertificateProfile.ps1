[cmdletbinding()]
param (
    [parameter(Mandatory = $true)]
    [string]$DisplayName,

    [parameter(Mandatory = $true)]
    [System.IO.FileInfo]$RootCertificate,

    [parameter(Mandatory=$true)]
    [ValidateSet("ComputerRoot", "ComputerIntermediate", "UserIntermediate")]
    [string]$DestinationStore
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