if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    $zoxide_cache = "$HOME\.zoxide-cache.ps1"
    if (-not (Test-Path $zoxide_cache)) {
        zoxide init powershell > $zoxide_cache
    }
    . $zoxide_cache
}