$LazySetup = @{
    # Git: Load module posh-git
    'git' = { 
        Import-Module posh-git 
    }

    # Choco: Load helper profile
    'choco' = {
        $cp = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
        if (Test-Path $cp) { Import-Module $cp }
    }
}

foreach ($cmd in $LazySetup.Keys) {
    $sb = [ScriptBlock]::Create(@"
        function global:$cmd {
            Remove-Item function:$cmd -ErrorAction SilentlyContinue
            
            Write-Host "Lazy loading context for $cmd..." -ForegroundColor DarkGray
            
            & `$LazySetup['$cmd']

            if (Get-Command $cmd -CommandType Application -ErrorAction SilentlyContinue) {
                & $cmd @args
            } else {
                & $cmd @args
            }
        }
"@)
    & $sb
}