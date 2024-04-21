local template = require("nightfox.util.template")
local Color = require("nightfox.lib.color")

local M = {}

function M.generate(spec, _)
  local theme_type = 'dark'
  if spec.palette.meta.light then
    theme_type = 'light'
  end

  local colors = {
    palette = spec.palette,
    theme_type = theme_type,

    -- This has to be increased in saturation and lightness so that it can contrast
    -- with white text as the foreground. Also obsidian increases the lightness
    -- so maybe reverse engineer that claculation?
    accent_h = string.format("%.2f", Color(spec.palette.magenta.dim):to_hsl().hue),
    accent_s = string.format("%.2f", Color(spec.palette.magenta.dim):to_hsl().saturation),
    accent_l = string.format("%.2f", Color(spec.palette.magenta.dim):to_hsl().lightness),
    mono100 = Color(spec.fg1):to_rgba(),
    mono0 = Color(spec.bg0):to_rgba(),
    base110 = Color(spec.fg0):to_css(),
    base100 = Color(spec.fg1):to_css(),
    base70 = Color(spec.fg2):to_css(),
    base60 = Color(spec.fg3):to_css(),
    base50 = Color(spec.fg3):blend(Color(spec.bg4), 0.33):to_css(),
    base40 = Color(spec.fg3):blend(Color(spec.bg4), 0.66):to_css(),
    base35 = Color(spec.bg4):to_css(),
    base30 = Color(spec.bg3):to_css(),
    base25 = Color(spec.bg3):blend(Color(spec.bg2), 0.5):to_css(),
    base20 = Color(spec.bg2):to_css(),
    base10 = Color(spec.bg1):to_css(),
    base05 = Color(spec.bg1):blend(Color(spec.bg0), 0.5):to_css(),
    base00 = Color(spec.bg0):to_css(),

    cyan = Color(spec.palette.cyan.base):to_rgba(),
    pink = Color(spec.palette.pink.base):to_rgba(),
    purple = Color(spec.palette.magenta.base):to_rgba(),
    blue = Color(spec.palette.blue.base):to_rgba(),
    orange = Color(spec.palette.orange.base):to_rgba(),
    red = Color(spec.palette.red.base):to_rgba(),
    yellow = Color(spec.palette.yellow.base):to_rgba(),
    green = Color(spec.palette.green.base):to_rgba(),
  }
  local content = [[
.theme-${theme_type} {
  --accent-h: ${accent_h};
  --accent-s: ${accent_s}%;
  --accent-l: ${accent_l}%;
  --mono-rgb-100: ${mono100.red}, ${mono100.green}, ${mono100.blue};
  --mono-rgb-0: ${mono0.red}, ${mono0.green}, ${mono0.blue};
  --color-base-110: ${base110};
  --color-base-100: ${base100};
  --color-base-70: ${base70};
  --color-base-60: ${base60};
  --color-base-50: ${base50}; /* outside of original spec */
  --color-base-40: ${base40}; /* outside of original spec */
  --color-base-35: ${base35};
  --color-base-30: ${base30};
  --color-base-25: ${base25}; /* outside of original spec */
  --color-base-20: ${base20};
  --color-base-10: ${base10};
  --color-base-05: ${base05}; /* outside of original spec */
  --color-base-00: ${base00};

  --color-cyan: ${palette.cyan.base};
  --color-cyan-bright: ${palette.cyan.bright};
  --color-cyan-dim: ${palette.cyan.dim};
  --color-pink: ${palette.pink.base};
  --color-pink-bright: ${palette.pink.bright};
  --color-pink-dim: ${palette.pink.dim};
  --color-purple: ${palette.magenta.base};
  --color-purple-bright: ${palette.magenta.bright};
  --color-purple-dim: ${palette.magenta.dim};
  --color-blue: ${palette.blue.base};
  --color-blue-bright: ${palette.blue.bright};
  --color-blue-dim: ${palette.blue.dim};
  --color-orange: ${palette.orange.base};
  --color-orange-bright: ${palette.orange.bright};
  --color-orange-dim: ${palette.orange.dim};
  --color-red: ${palette.red.base};
  --color-red-bright: ${palette.red.bright};
  --color-red-dim: ${palette.red.dim};
  --color-yellow: ${palette.yellow.base};
  --color-yellow-bright: ${palette.yellow.bright};
  --color-yellow-dim: ${palette.yellow.dim};
  --color-green: ${palette.green.base};
  --color-green-bright: ${palette.green.bright};
  --color-green-dim: ${palette.green.dim};

  --color-cyan-rgb: ${cyan.red}, ${cyan.green}, ${cyan.blue};
  --color-pink-rgb: ${pink.red}, ${pink.green}, ${pink.blue};
  --color-purple-rgb: ${purple.red}, ${purple.green}, ${purple.blue};
  --color-blue-rgb: ${blue.red}, ${blue.green}, ${blue.blue};
  --color-orange-rgb: ${orange.red}, ${orange.green}, ${orange.blue};
  --color-red-rgb: ${red.red}, ${red.green}, ${red.blue};
  --color-yellow-rgb: ${yellow.red}, ${yellow.green}, ${yellow.blue};
  --color-green-rgb: ${green.red}, ${green.green}, ${green.blue};

  --code-comment: ${palette.comment};
  --code-inline-background: var(--color-base-00);
}

body {
  --background-primary: var(--color-base-10);
  --background-primary-alt: var(--color-base-05);
  --background-secondary: var(--color-base-05);
  --code-background: var(--color-base-05);
  --code-inline-background: var(--code-background);
  --titlebar-background: var(--color-base-00);
  --titlebar-background-focused: var(--color-base-00);
  --ribbon-background: var(--color-base-00);
  --ribbon-background-collapsed: var(--color-base-05);
  --modal-border-color: var(--color-base-30);
  --background-modifier-border: var(--color-base-25);
  --background-modifier-border-hover: var(--color-base-30);
  --background-modifier-border-focus: var(--color-base-35);
  --table-header-background: var(--color-base-05);
  --table-header-background-hover: var(--color-base-05);
  --blockquote-background-color: rgba(var(--color-blue-rgb), 0.05);
  --bold-color: var(--color-base-110);

  --heading-color: var(--color-base-110);
  --h1-color: var(--heading-color);
  --h2-color: var(--heading-color);
  --h3-color: var(--heading-color);
  --h4-color: var(--heading-color);
  --h5-color: var(--heading-color);
  --h6-color: var(--heading-color);
}

.markdown-rendered code {
  background-color: var(--code-inline-background);
}
]]

  return template.parse_template_str(content, colors)
end

return M
