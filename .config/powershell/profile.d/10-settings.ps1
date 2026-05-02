$env:PATH = (($env:PATH -split ';' | Where-Object { $_ }) | Select-Object -Unique) -join ';'


if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -BellStyle None
    
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -HistoryNoDuplicates

    Set-PSReadLineOption -PredictionViewStyle ListView
    
    Set-PSReadLineOption -Colors @{

        "ListPrediction" = ([ConsoleColor]::DarkGray)

        "ListPredictionSelected" = ([ConsoleColor]::Cyan)

        "InlinePrediction" = ([ConsoleColor]::DarkGray)
    }
}