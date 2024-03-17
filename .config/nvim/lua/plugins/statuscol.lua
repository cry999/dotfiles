--[[
This file is for the 'statuscolumn' configuration.
'statuscolumn' consists of fold, gitsign and lsp diagnostics.
--]]
return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    local c = require('statuscol.ffidef').C
    require("statuscol").setup({
      relculright = true,
      segments = {
        -- gitsigns
        {
          sign = {
            namespace = { "gitsigns" },
            name      = { '.*' },
            maxwidth  = 1,
            colwidth  = 1,
            auto      = false,
          },
          -- condition = { function(args) return args.sclnu end },
        },
        -- diagnostics
        {
          sign = {
            namespace = { "diagnostic" },
            name      = { "error", "warn", "info", "hint" },
            maxwidth  = 1,
            colwidth  = 1,
            auto      = false,
          },
          -- condition = { function(args) return args.sclnu end },
        },
        -- fold
        {
          text = {
            -- Amazing foldcolumn
            -- https://github.com/kevinhwang91/nvim-ufo/issues/4
            function(args)
              local foldinfo = c.fold_info(args.wp, args.lnum)
              local foldinfo_next = c.fold_info(args.wp, args.lnum + 1)
              local level = foldinfo.level
              local foldstr = ' '
              local hl = '%#FoldCol' .. level .. '#'
              if level == 0 then
                hl = '%#LineNr#'
                foldstr = ' '
                return hl .. foldstr .. '%#LineNr# '
              end
              if level > 8 then
                hl = '%#FoldCol8#'
              end
              if foldinfo.lines ~= 0 then
                foldstr = ''
              elseif args.lnum == foldinfo.start then
                foldstr = ''
              elseif
                  foldinfo.level > foldinfo_next.level
                  or (
                    foldinfo_next.start == args.lnum + 1
                    and foldinfo_next.level == foldinfo.level
                  )
              then
                foldstr = ''
              end
              return hl .. foldstr .. '%#LineNr# '
            end,
          },
        },
        -- line number
        {
          text = { builtin.lnumfunc, " " },
        },
      },
    })
  end,
}
