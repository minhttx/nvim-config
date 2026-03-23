local M = {}

function M.setup()
  -- 1. Apply base16 palette (Noctalia → base16)
  require('base16-colorscheme').setup {
    -- Background tones
    base00 = '#131412', -- Normal background
    base01 = '#1f201e', -- Statusline / UI bg
    base02 = '#292a28', -- Selection
    base03 = '#91918e', -- Comments

    -- Foreground tones
    base04 = '#c7c6c3', -- Dark fg
    base05 = '#e4e2df', -- Default fg
    base06 = '#e4e2df',
    base07 = '#e4e2df',

    -- Accent colors
    base08 = '#ffb4ab', -- Errors
    base09 = '#b8ccb5', -- Constants
    base0A = '#c1c9be', -- Types / Search
    base0B = '#bdcab9', -- Strings
    base0C = '#b8ccb5', -- Regex
    base0D = '#bdcab9', -- Functions
    base0E = '#c1c9be', -- Keywords
    base0F = '#93000a', -- Deprecated
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
