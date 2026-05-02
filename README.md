# My Dotfiles

This is my personal configuration for PowerShell and Neovim.

The main goal here is speed. PowerShell is notoriously slow to start if you have a bloated profile. This setup fixes that by compiling multiple config files into a single static script to reduce disk I/O, and relies heavily on lazy-loading.

## How it works

### PowerShell
Instead of dot-sourcing a bunch of different files every time you open a terminal, this setup uses a build step. 

You write your aliases and settings in `.config/powershell/`, run `build.ps1`, and it concatenates everything into one single `user_profile.ps1`. The shell only reads this one file on boot.

- **Lazy Loading**: Heavy modules like `posh-git` or `choco` are not loaded until you actually type their commands.
- **Caching**: `oh-my-posh` and `zoxide` initialization scripts are cached to disk so we don't spawn child processes every time a new tab opens.

### Neovim
Standard modular Lua setup. Separated by OS (Mac/Windows). Nothing fancy, just clean structure. `init.lua` only requires the necessary modules.

## Installation

**Do not edit `user_profile.ps1` manually. Your changes will be overwritten.**

1. Clone this repo.
2. Edit whatever you need inside `.config/powershell/` (e.g., `10-settings.ps1`, `20-aliases.ps1`).
3. Run the build script to generate your profile:
   ```powershell
   ./.config/powershell/build.ps1
   ```
4. Restart your shell. If you are already inside, just type `bpl` to rebuild and reload instantly.

## Dependencies

- PowerShell Core 7+
- Neovim 0.9+
- fzf
- fd
- zoxide
- oh-my-posh

## Extra Features
- **Safe Delete**: I replaced the default `rm` alias. It uses a custom wrapper that explicitly blocks you from accidentally deleting your `$env:SystemRoot` or `Desktop` folders.
- **Fuzzy Finding**: `Ctrl+R` and `Ctrl+F` are bound to `fzf` for history and directory jumping. If you don't have `fd` installed, it falls back to native PowerShell cmdlets gracefully.
