Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue

$themePath = Join-Path $PSScriptRoot "themes\foxiezi.omp.json"
$posh_cache = "$HOME\.posh-cache.ps1"

if (!(Test-Path $posh_cache)) {
    oh-my-posh init pwsh --config $themePath > $posh_cache
}
. $posh_cache