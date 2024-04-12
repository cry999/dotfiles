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
        -- gitsigns and diagnostic
        {
          sign = {
            namespace = { "gitsigns", "diagnostic" },
            name      = { '.*' },
            maxwidth  = 1,
            colwidth  = 2,
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
                -- foldstr = ''
                foldstr = ' '
              elseif
                  foldinfo.level > foldinfo_next.level
                  or (
                    foldinfo_next.start == args.lnum + 1
                    and foldinfo_next.level == foldinfo.level
                  )
              then
                -- foldstr = ''
                foldstr = ' '
              end
              return hl .. foldstr .. '%#LineNr# '
            end,
          },
          condition = {
            function(args)
              local filetype = vim.bo[args.buf].filetype
              return
                  filetype ~= "neo-tree" and
                  filetype ~= "neotest-summary" and
                  filetype ~= "alpha" and
                  filetype:sub(1, #"Neogit") ~= "Neogit"
            end
          },
        },
        -- select line number
        {
          text = {
            function(args)
              local pos = vim.fn.getpos('.')
              local lnum = pos[2]
              if args.lnum == lnum then
                return "%#CursorLineNr#"
              else
                return " "
              end
            end,
          },
          condition = {
            function(args)
              local ft = vim.bo[args.buf].filetype
              return vim.api.nvim_get_current_buf() == args.buf and
                  ft ~= "neotest-summary" and
                  ft ~= "alpha" and
                  ft:sub(1, #"Neogit") ~= "Neogit"
            end
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
