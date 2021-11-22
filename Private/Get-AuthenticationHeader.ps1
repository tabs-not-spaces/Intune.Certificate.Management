function Get-AuthenticationHeader {
    [cmdletbinding()]
    param (
        [parameter(Mandatory = $false)]
        [string]$TenantId
    )
    try {
        #region Authentication
        $script:tick = [char]0x221a
        $authParams = @{
            ClientId   = 'd1ddf0e4-d672-4dae-b554-9d5bdfd93547'
            DeviceCode = $true
        }
        if ($TenantId) {
            $authParams.TenantId = $TenantId
        }
        $authRequest = ( Get-MsalToken @authParams )
        $script:authHeader = @{ Authorization = $authRequest.CreateAuthorizationHeader() }
        if ($null -eq $script:authHeader.Authorization) {
            throw "Authorization request has not returned an auth header"
        }
        else {
            Write-Host " Authentication successful $script:Tick " -BackgroundColor Green -ForegroundColor Black
        }
        #endregion
    }
    catch {
        Write-Warning $_.Exception.Message
    }

}