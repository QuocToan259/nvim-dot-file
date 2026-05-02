function which ($command) {
    (Get-Command -Name $command -ErrorAction SilentlyContinue).Path
}

# Build
function build-profile {
    $profileDir = "$env:USERPROFILE\.config\powershell"
    $buildScript = Join-Path $profileDir "build.ps1"

    if (Test-Path $buildScript) {
        Write-Host "Executing build script: $buildScript" -ForegroundColor Yellow
        & $buildScript
        
        if ($LASTEXITCODE -eq 0 -or $?) {
            . $PROFILE
            Write-Host "Profile re-compiled and reloaded!" -ForegroundColor Cyan
        } else {
            Write-Host "Error: Build script failed!" -ForegroundColor Red
        }
    } else {
        Write-Host "Warning: build.ps1 not found at $profileDir" -ForegroundColor Yellow
        Write-Host "Reloading current profile instead..." -ForegroundColor Gray
        . $PROFILE
        Write-Host "Profile reloaded (without build)!" -ForegroundColor Cyan
    }
}

# Trashy
if (Get-Alias rm -ErrorAction SilentlyContinue) { 
    Remove-Item alias:rm -Force 
}

function rm {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true, Position=0, Mandatory=$true)]
        [string[]]$Path,
        [Parameter(ValueFromRemainingArguments=$true)]$RemainingArgs
    )

    process {
        $Red = "$([char]27)[1;31m"; $Reset = "$([char]27)[0m"
        
        $Protected = @("$env:SystemRoot", "$env:USERPROFILE\Desktop") | ForEach-Object { [System.IO.Path]::GetFullPath($_).TrimEnd('\') }

        foreach ($item in $Path) {
            if (-not (Test-Path $item)) { continue }
            
            $target = [System.IO.Path]::GetFullPath($item).TrimEnd('\')
            
            foreach ($p in $Protected) {
                if ($target -eq $p -or $target.StartsWith("$p\")) {
                    Write-Host "${Red}BLOCKED:${Reset} Cannot delete protected path: $target"
                    continue
                }
            }

            if (Get-Command trash -ErrorAction SilentlyContinue) {
                trash $target
            } else {
                Remove-Item -Path $target -Recurse -Force -ErrorAction SilentlyContinue
            }
        }
    }
}
# Fzf
function fzcd {
    if (Get-Command fd -ErrorAction SilentlyContinue) {
        $selection = fd --type d --color never | fzf --height 40% --reverse --border --header "Jump to Directory"
    } else {
        $selection = Get-ChildItem -Directory -Recurse -ErrorAction SilentlyContinue | 
                     ForEach-Object { $_.FullName } | 
                     fzf --height 40% --reverse --border --header "Jump to Directory"
    }
    
    if ($selection) {
        Set-Location $selection
        ls
    }
}

function wipe-history {
    $confirm = Read-Host "Clear history? (y/n)"
    if ($confirm -eq 'y') {
        $historyPath = (Get-PSReadLineOption).HistorySavePath
        if (Test-Path $historyPath) {
            Remove-Item $historyPath -Force
        }
        
        [Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
        Clear-History
        
        Write-Host "History nuke complete. Clean slate." -ForegroundColor Cyan
    } else {
        Write-Host "Aborted." -ForegroundColor Yellow
    }
}


Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock {
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    if (-not (Test-Path $historyPath)) { return }

    $line = ""
    $cursor = 0
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    $history = Get-Content $historyPath -ErrorAction SilentlyContinue | Select-Object -Unique
    
    $selection = $history | fzf --height 40% --reverse --tac --query $line
    
    if ($selection) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $selection)
    }
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -ScriptBlock {
    try {
        $cmd = if (Get-Command fd -ErrorAction SilentlyContinue) { 
            "fd --type d --color never 2>$null" 
        } else { 
            "Get-ChildItem -Directory -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName" 
        }

        $selection = Invoke-Expression "$cmd | fzf --reverse --header 'Jump to Directory'"

        if ($selection) {
            [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("cd `"$selection`"")
            [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        } else {

            [Microsoft.PowerShell.PSConsoleReadLine]::RedrawLine()
        }
    }
    catch {

    }
}

# Aliases
Set-Alias vim nvim
Set-Alias g git
Set-Alias ll ls
Set-Alias wp wipe-history
Set-Alias bpl build-profile