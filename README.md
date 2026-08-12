# WezTerm Config

Personal, version-controlled configuration for the [WezTerm](https://wezfurlong.org/wezterm/) terminal emulator on Windows. This repository exists to keep the terminal setup reproducible: clone it, link the config file into place, and the environment is ready on any machine.

## Table of Contents

- [Overview](#overview)
- [What's Inside](#whats-inside)
- [Getting Started](#getting-started)
- [Customization](#customization)
- [Key & Mouse Bindings](#key--mouse-bindings)
- [References](#references)

## Overview

The entire configuration lives in a single file, `.wezterm.lua`, which WezTerm loads automatically from the user home directory. It covers shell launch options, a custom color palette, switchable background gradient styles, fonts, window appearance, and clipboard-friendly paste bindings.

### Key Features

- Launch menu for PowerShell, PowerShell 7, and Command Prompt
- Three switchable background gradient styles (matrix, bluered, glass) with per-style opacity
- Custom green/red/blue cyberpunk-inspired color palette and styled tab bar
- Nerd Font with fallback chain
- Ctrl+V and right-click paste from the clipboard

## What's Inside

```
wezterm_config/
└── .wezterm.lua    # Complete WezTerm configuration (single source of truth)
```

| Area | Setting |
|------|---------|
| Default shell | Windows PowerShell (`powershell.exe -NoLogo`) |
| Launch menu | PowerShell, PowerShell 7 (`pwsh.exe` via PATH), Command Prompt |
| Active style | `bluered` (radial blue/black/red gradient, 0.82 opacity) |
| Font | UbuntuMono Nerd Font Mono -> Fira Code -> Cascadia Code, size 13 |
| Cursor | Steady bar, 500 ms blink |
| Scrollback | 5000 lines |
| Tab bar | Fancy tab bar, custom active/inactive colors |

## Getting Started

### Prerequisites

- [WezTerm](https://wezfurlong.org/wezterm/install/windows.html) installed
- [UbuntuMono Nerd Font](https://www.nerdfonts.com/font-downloads) installed (otherwise the fallback fonts are used)
- Optional: [PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows) for the PowerShell 7 launch menu entry

### Installation

1. Clone the repository:

```powershell
git clone https://github.com/abrmeval/wezterm_config.git
```

2. Make the config visible to WezTerm at `%USERPROFILE%\.wezterm.lua`. Choose one:

   - Option A: Symbolic link (recommended, keeps the repo as the single source of truth). Requires Developer Mode or an elevated shell:

   ```powershell
   New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "C:\path\to\wezterm_config\.wezterm.lua"
   ```

   - Option B: Plain copy (must re-copy after every change):

   ```powershell
   Copy-Item "C:\path\to\wezterm_config\.wezterm.lua" "$HOME\.wezterm.lua"
   ```

3. Restart WezTerm, or press `Ctrl+Shift+R` in an existing window to reload the configuration.

### Verification

- WezTerm opens with the gradient background and custom colors
- The tab bar launch menu shows PowerShell, PowerShell 7, and Command Prompt entries
- `Ctrl+V` pastes clipboard contents into the terminal

## Customization

### Switching the background style

Edit the `STYLE` constant at the top of `.wezterm.lua`:

```lua
local STYLE = "bluered" -- "matrix" | "bluered" | "glass"
```

| Style | Look | Opacity |
|-------|------|---------|
| `matrix` | Black-to-green diagonal gradient, terminal-hacker vibe | 0.85 |
| `bluered` | Blue-to-black-to-red radial gradient, cyberpunk dashboard | 0.82 |
| `glass` | Near-black gradient, heaviest transparency | 0.68 |

### Adding a launch menu entry

Append an entry to `config.launch_menu`:

```lua
{ label = "WSL", args = { "wsl.exe" } },
```

## Key & Mouse Bindings

Custom bindings added by this config (all WezTerm defaults remain active):

| Input | Action |
|-------|--------|
| `Ctrl+V` | Paste from clipboard |
| Right-click | Paste from clipboard |

Useful built-in defaults:

| Input | Action |
|-------|--------|
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+R` | Reload configuration |
| `Ctrl+Shift+T` | New tab |

## References

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [WezTerm Config File Reference](https://wezfurlong.org/wezterm/config/files.html)
- [WezTerm Default Key Bindings](https://wezfurlong.org/wezterm/config/default-keys.html)
- [Nerd Fonts](https://www.nerdfonts.com/)

*Last Updated: 12 Aug 2026*
