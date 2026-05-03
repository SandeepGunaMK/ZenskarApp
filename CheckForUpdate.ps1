param (
    [string]$localVersion
)

$versionUrl = "https://raw.githubusercontent.com/SandeepGunaMK/ZenskarApp/main/version.txt"

try {
    $remoteVersion = Invoke-RestMethod -Uri $versionUrl
} catch {
    Write-Host "FAILED"
    exit 1
}

$remoteVersion = $remoteVersion.Trim()

Write-Host "Local: $localVersion"
Write-Host "Remote: $remoteVersion"

if ([version]$remoteVersion -gt [version]$localVersion) {
    Write-Host "UPDATE AVAILABLE"
    exit 2
}
else {
    Write-Host "UP TO DATE"
    exit 0
}