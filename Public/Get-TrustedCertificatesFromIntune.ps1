function Get-TrustedCertificatesFromIntune {
    [cmdletbinding()]
    param (
        [parameter(Mandatory = $false)]
        [string]$TenantId
    )
    #region Auth
    if ($null -eq $Script:authHeader) {
        $TenantId ? (Get-AuthenticationHeader -TenantId $TenantId) : (Get-AuthenticationHeader)
    }
    #endregion

    try {
        #region Query Graph
        $baseUri = 'https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations'
        $graphParams = @{
            Method      = 'Get'
            Uri         = $baseUri
            Headers     = $Script:authHeader
            ContentType = 'Application/Json'
        }
        $result = Invoke-RestMethod @graphParams
        $resultValue = $result.value.Count -gt 0 ? $result.value : $null
        #endregion
        #region Format the results
        $foundCertificates = $resultValue | Where-Object { $_.'@odata.type' -like "#microsoft.graph.*TrustedRootCertificate" }
        if ($foundCertificates.Count -gt 0) {
            Write-Verbose "$($foundCertificates.Count) Trusted certificates found"
            return $foundCertificates
        }
        #endregion
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}