param (
    [string]$dllPath,
    [string]$repoOwner = "SandeepGunaMK",
    [string]$repoName = "ZenskarApp",
    [string]$branch = "main",
    [string]$token = ""  # optional (only if private repo)
)

Write-Host "Checking for updates..."

# 🔹 Validate DLL
if (!(Test-Path $dllPath)) {
    Write-Host "ERROR: DLL not found"
    exit 1
}

# 🔹 Get local modified date
$localDate = (Get-Item $dllPath).LastWriteTimeUtc
Write-Host "Local DLL Date (UTC): $localDate"

# 🔹 Build GitHub API URL
$apiUrl = "https://api.github.com/repos/$repoOwner/$repoName/commits/$branch"

# 🔹 Headers (token optional)
$headers = @{
    "User-Agent" = "WPF-Updater"
}

if ($token -ne "") {
    $headers["Authorization"] = "Bearer $token"
}

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get
}
catch {
    Write-Host "ERROR: Failed to fetch commit info"
    Write-Host $_
    exit 1
}

# 🔹 Extract commit date
$commitDate = [datetime]$response.commit.committer.date
Write-Host "Latest Commit Date (UTC): $commitDate"

# 🔹 Compare
if ($commitDate -gt $localDate) {
    Write-Host "UPDATE AVAILABLE"
}
else {
    Write-Host "UP TO DATE"
}

# Optional: pause for debugging
# Read-Host "Press Enter to exit"