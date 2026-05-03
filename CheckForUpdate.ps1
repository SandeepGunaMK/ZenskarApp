param (
    [string]$versionUrl = "https://raw.githubusercontent.com/SandeepGunaMK/ZenskarApp/main/version.txt"
)

try {
    $remoteVersion = Invoke-RestMethod -Uri $versionUrl
    $remoteVersion = $remoteVersion.Trim()

    Write-Output $remoteVersion
    exit 0
}
catch {
    Write-Error "FAILED"
    exit 1
}