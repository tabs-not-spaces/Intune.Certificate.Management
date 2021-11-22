function Get-CertificateDataFromTrustedCertificatePolicy {
    [cmdletbinding()]
    param (
        [parameter(Mandatory = $True)]
        [PSCustomObject]$TrustedRootCertificate
    )
    try {
        $decryptedTRC = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($TrustedRootCertificate.trustedRootCertificate))
        $formattedCertContent = ($decryptedTRC -replace "-----BEGIN CERTIFICATE-----|-----END CERTIFICATE-----", "").Trim()
        $decryptedCertificate = [System.Security.Cryptography.X509Certificates.X509Certificate2]([System.Convert]::FromBase64String($formattedCertContent))
        return $decryptedCertificate
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}