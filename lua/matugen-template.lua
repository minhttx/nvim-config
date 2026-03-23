local M = {}

function M.setup()
  -- 1. Apply base16 palette (Noctalia → base16)
  require('base16-colorscheme').setup {
    -- Background tones
    base00 = '{{colors.surface.default.hex}}', -- Normal background
    base01 = '{{colors.surface_container.default.hex}}', -- Statusline / UI bg
    base02 = '{{colors.surface_container_high.default.hex}}', -- Selection
    base03 = '{{colors.outline.default.hex}}', -- Comments

    -- Foreground tones
    base04 = '{{colors.on_surface_variant.default.hex}}', -- Dark fg
    base05 = '{{colors.on_surface.default.hex}}', -- Default fg
    base06 = '{{colors.on_surface.default.hex}}',
    base07 = '{{colors.on_background.default.hex}}',

    -- Accent colors
    base08 = '{{colors.error.default.hex}}', -- Errors
    base09 = '{{colors.tertiary.default.hex}}', -- Constants
    base0A = '{{colors.secondary.default.hex}}', -- Types / Search
    base0B = '{{colors.primary.default.hex}}', -- Strings
    base0C = '{{colors.tertiary_fixed_dim.default.hex}}', -- Regex
    base0D = '{{colors.primary_fixed_dim.default.hex}}', -- Functions
    base0E = '{{colors.secondary_fixed_dim.default.hex}}', -- Keywords
    base0F = '{{colors.error_container.default.hex}}', -- Deprecated
  }

  -- 2. Normalize Neovim UI (FIX triệt để các mảng màu lệch)
  vim.cmd [[
    " Core background
    hi! Normal       guibg=NONE
    hi! NormalNC     guibg=NONE

    " Gutter / columns
    hi! link SignColumn Normal
    hi! link LineNr Normal
    hi! link FoldColumn Normal

    " End of buffer (THỦ PHẠM 2 MẢNG MÀU)
    hi! link EndOfBuffer Normal

    " Floating windows
    hi! link NormalFloat Normal
    hi! link FloatBorder Normal

    " Window separators
    hi! link WinSeparator Normal

    " Statusline
    hi! link StatusLine Normal
    hi! link StatusLineNC Normal

    " Cursor / selection
    hi! Visual       gui=reverse
    hi! CursorLine   guibg=NONE
    hi! CursorLineNr gui=bold

    " Search
    hi! Search    gui=reverse
    hi! IncSearch gui=reverse
  ]]
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
