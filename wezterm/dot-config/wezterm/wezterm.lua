local wezterm = require('wezterm')

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.wsl_domains = {
  {
    name = "WSL:Ubuntu",
    distribution = 'Ubuntu',
  }
}
config.default_domain = 'WSL:Ubuntu'

-- config.font = wezterm.font ''

config.color_scheme = 'Dracula (Official)'
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

config.max_fps = 240

config.window_background_opacity = 0.85

config.font = wezterm.font 'Cascadia Mono'

return config
