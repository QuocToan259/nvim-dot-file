$CONF_DIR = Split-Path $PSCommandPath
$PROFILE_D = Join-Path $CONF_DIR "profile.d"
$TARGET = Join-Path $CONF_DIR "user_profile.ps1"

$header = @"
# ==========================================
# AUTO-GENERATED STATIC PROFILE - DO NOT EDIT
# Build Date: $(Get-Date)
# ==========================================
"@

$code = Get-ChildItem -Path $PROFILE_D -Filter *.ps1 | Sort-Object Name | ForEach-Object {
    "`n# --- Source: $($_.Name) ---`n" + (Get-Content $_.FullName -Raw)
}

$header + $code | Set-Content -Path $TARGET -Encoding utf8
Write-Host "Success: Compiled modular profiles into $TARGET" -ForegroundColor Green