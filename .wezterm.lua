-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local STYLE = "bluered"

config.launch_menu = {
  { label = "PowerShell", args = { "powershell.exe", "-NoLogo" } },
  { label = "PowerShell 7", args = { "pwsh.exe", "-NoLogo" } },
  { label = "Command Prompt", args = { "cmd.exe" } },
}

config.default_prog = { "powershell.exe", "-NoLogo" }

-- ============================================================
-- SHARED BASE COLORS (green / red / white / black / blue palette)
-- ============================================================
config.colors = {
  foreground = "#e6f2e6",
  background = "#0a0e0a",
  cursor_bg = "#39ff88",
  cursor_fg = "#0a0e0a",
  cursor_border = "#39ff88",
  selection_bg = "#1e3a5f",
  selection_fg = "#ffffff",
 
  ansi = {
    "#0a0e0a", -- black
    "#ff4d4d", -- red
    "#39ff88", -- green
    "#f1fa8c", -- yellow (kept muted, used sparingly)
    "#3b82f6", -- blue
    "#a855f7", -- magenta (subtle accent)
    "#22d3ee", -- cyan
    "#f5f5f5", -- white
  },
  brights = {
    "#4a4a4a", -- bright black
    "#ff7a7a", -- bright red
    "#6dffb0", -- bright green
    "#f9f871", -- bright yellow
    "#60a5fa", -- bright blue
    "#c084fc", -- bright magenta
    "#67e8f9", -- bright cyan
    "#ffffff", -- bright white
  },
 
  tab_bar = {
    background = "#0a0e0a",
    active_tab = {
      bg_color = "#111a11",
      fg_color = "#39ff88",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#0a0e0a",
      fg_color = "#5c6b5c",
    },
    inactive_tab_hover = {
      bg_color = "#1e3a5f",
      fg_color = "#3b82f6",
    },
    new_tab = {
      bg_color = "#0a0e0a",
      fg_color = "#ff4d4d",
    },
  },
}

-- ============================================================
-- STYLE 1: "matrix" — black-to-green diagonal gradient,
-- red cursor accent, high transparency, terminal-hacker vibe
-- ============================================================
local matrix_gradient = {
  colors = { "#000000", "#031a0d", "#04240f", "#000000" },
  orientation = { Linear = { angle = -45.0 } },
  interpolation = "Linear",
  blend = "Rgb",
  noise = 0,
}

-- ============================================================
-- STYLE 2: "bluered" — blue-to-black-to-red radial gradient,
-- white text pops against it, more "cyberpunk dashboard"
-- ============================================================
local bluered_gradient = {
  colors = { "#2a0d0d", "#000000", "#0a111a" },
  orientation = { Radial = { radius = 1.2, cx = 0.2, cy = 0.1 } },
  interpolation = "CatmullRom",
  blend = "Rgb",
  noise = 0,
}
 
-- ============================================================
-- STYLE 3: "glass" — subtle near-black gradient with heavy
-- transparency + blur, colors mostly come from text/UI, not bg
-- ============================================================
local glass_gradient = {
  colors = { "#050505", "#0a1512", "#050505" },
  orientation = { Linear = { angle = 30.0 } },
  interpolation = "Linear",
  blend = "Rgb",
  noise = 0,
}

local gradients = {
  matrix = matrix_gradient,
  bluered = bluered_gradient,
  glass = glass_gradient,
}
 
local opacities = {
  matrix = 0.85,
  bluered = 0.82,
  glass = 0.68, -- most transparent / "glass" look
}

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28


config.window_background_gradient = gradients[STYLE]
config.window_background_opacity = opacities[STYLE]
config.text_background_opacity = 1.0


-- ============================================================
-- FONT & UI — modern dev look
-- ============================================================
config.font = wezterm.font_with_fallback {
  "UbuntuMono Nerd Font Mono",
  "Fira Code",
  "Cascadia Code",
}
config.font_size = 13.0
config.line_height = 1.1

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 14,
  right = 14,
  top = 10,
  bottom = 10,
}
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false


-- Cursor
config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 500

-- Scrollback / misc QoL
config.scrollback_lines = 5000
config.audible_bell = "Disabled"

-- ============================================================
-- PASTE — Ctrl+V and right-click paste from the clipboard.
-- (Ctrl+Shift+V keeps working via WezTerm's defaults.)
-- ============================================================
config.keys = {
  { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom "Clipboard" },
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action.PasteFrom "Clipboard",
  },
}


-- Finally, return the configuration to wezterm:
return config