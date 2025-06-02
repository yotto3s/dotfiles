local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.initial_cols = 620
config.initial_rows = 480

config.font_size = 12

config.default_prog = { '/usr/bin/bash', '-i' }
config.warn_about_missing_glyphs=false

return config
