local diff = function(icons, colors)
  return {
    "diff",
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      return gitsigns and {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      } or {}
    end,
    symbols = {
      added = icons.GitAdd .. " ",
      modified = icons.GitChange .. " ",
      removed = icons.GitDelete .. " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  }
end

local diagnostics = function(icons, _)
  return {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
      error = icons.DiagnosticError .. ' ',
      hint = icons.DiagnosticHint .. ' ',
      info = icons.DiagnosticInfo .. ' ',
      warn = icons.DiagnosticWarn .. ' ',
    },
  }
end

local recording = function(icons, colors)
  return {
    'macro-recording',
    fmt = function()
      local reg = vim.fn.reg_recording()
      return reg == '' and '' or icons.MacroRecording .. ' ' .. reg
    end,
    color = { fg = colors.yellow, bold = true },
  }
end

local enable_fileinfo = function()
  return vim.bo[0].buftype ~= 'nofile' and
      vim.bo[0].buftype ~= 'help' and
      vim.bo[0].filetype ~= 'toggleterm'
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
  },
  config = function()
    local colors = require('catppuccin.palettes').get_palette()
    local icons = require('icons')
    require('lualine').setup({
      options = {
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        component_separators = { left = '│', right = '│' },
        disabled_filetypes = {
          statusline = { 'alpha' },
          winbar = { 'alpha', 'help', 'toggleterm', 'neo-tree', 'neotest-summary', 'neotest-output' },
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            separator = { left = '', right = '' },
            right_padding = 2,
            fmt = function(str) return str:sub(1, 1) end,
          },
        },
        lualine_b = { 'branch', diff(icons, colors) },
        lualine_c = {
          { 'filename', fmt = function(s) return '%=' .. s end, cond = enable_fileinfo },
        },

        lualine_x = {
          recording(icons, colors),
          diagnostics(icons, colors),
          { 'filetype', cond = enable_fileinfo },
        },
        lualine_y = { 'progress' },
        lualine_z = {
          {
            'location',
            separator = { left = '', right = '' },
            left_padding = 2,
          },
        },
      },
      winbar = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = { 'navic' },

        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},

        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
