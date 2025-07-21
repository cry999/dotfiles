-- TODO: Create NS
local colorify_ns = 1

local function needs_hl(buf, linenr, col, end_col, hl_group)
  local extmarks = vim.api.nvim_buf_get_extmarks(
    buf,
    colorify_ns,
    { linenr, col },
    { linenr, end_col },
    { details = true }
  )
  if #extmarks == 0 then
    return true, nil
  end
  for _, extmark in ipairs(extmarks) do
    if hl_group ~= (extmark[4].hl_group or extmark[4].virt_text[1][2]) then
      return true, extmark[1]
    end
  end
  return false, nil
end

---hex
---@param buf integer
---@param linenr integer
---@param str string
local function hex(buf, linenr, str)
  local hex_pattern = "()(#%x%x%x%x%x%x)"
  local matches = str:gmatch(hex_pattern)
  for col, match in matches do
    local hl_name = "hex_" .. match:sub(2)
    if not vim.api.nvim_get_hl(0, { name = hl_name }).fg then
      vim.api.nvim_set_hl(
        0, hl_name, { fg = match, bg = 'none', default = true }
      )
    end

    local needs, extmark_id = needs_hl(
      buf, linenr, col - 1, col + #match - 1, hl_name
    )
    if needs then
      vim.api.nvim_buf_set_extmark(buf, colorify_ns, linenr, col - 1, {
        virt_text = { { "󱓻 ", hl_name } },
        virt_text_pos = "inline",
        end_col = col + #match - 1,
        id = extmark_id,
      })
    end
  end
end

local function attach_colorify(buf, event)
  local winid = vim.fn.bufwinid(buf)

  if event == "TextChangedI" then
    local cur_linenr = vim.fn.line(".", winid) - 1

    hex(buf, cur_linenr, vim.api.nvim_get_current_line())
    -- lsp_var(buf, cur_linenr)
    return
  end

  local min, max = vim.fn.line("w0", winid) - 1, vim.fn.line("w$", winid) + 1
  local lines = vim.api.nvim_buf_get_lines(buf, min, max, false)

  -- hex
  for i, str in ipairs(lines) do
    hex(buf, min + i - 1, str)
  end
  -- lsp_var
  -- lsp_var(buf, nil, min, max)

  if not vim.b[buf].colorify_attached then
    vim.b[buf].colorify_attached = true

    vim.api.nvim_buf_attach(buf, false, {
      on_bytes = function(_, bufnr, _, start_row, start_col, _, old_end_row, old_end_col, _, _, new_end_col, _)
        if old_end_row == 0 and old_end_col == 0 and new_end_col == 0 then
          return
        end
        local row1, col1, row2, col2 = start_row, start_col, start_row, start_col + old_end_col
        if old_end_row > 0 then
          col1, row2, col2 = 0, start_row + old_end_row, 0
        end
        if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "i" then
          col1, col2 = 0, -1
        end
        local extmarks = vim.api.nvim_buf_get_extmarks(
          bufnr, colorify_ns, { row1, col1 }, { row2, col2 }, { overlap = true }
        )
        for _, extmark in ipairs(extmarks) do
          vim.api.nvim_buf_del_extmark(bufnr, colorify_ns, extmark[1])
        end
      end,
      on_detach = function(_, bufnr)
        vim.b[bufnr].colorify_attached = false
      end,
    })
  end
end

local autocmds = {
  scrollbar = {
    event = "CmdlineLeave",
    callback = function()
      local ok, s = pcall(require, "scrollbar.handlers.search")
      if ok then
        s.handler.hide()
      end
    end,
  },
  LSPInlayHintEnable = {
    event = { "LspAttach" },
    callback = function(args)
      if vim.lsp.inlay_hint ~= nil and not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }) then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
  },
  GitConfig = {
    event = { "BufRead", "BufNewFile" },
    pattern = "*.gitconfig",
    callback = function()
      vim.bo[0].filetype = "gitconfig"
    end,
  },
  TrimTrailingWhitespace = {
    event = "BufWritePre",
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", save_cursor)
    end,
  },
  Colorify = {
    event = {
      "TextChanged",
      "TextChangedI",
      "TextChangedP",
      "VimResized",
      "LspAttach",
      "WinScrolled",
      "BufEnter",
    },
    callback = function(args)
      if vim.bo[args.buf].bl then
        attach_colorify(args.buf, args.event)
      end
    end,
  },
}

for group, def in pairs(autocmds) do
  vim.api.nvim_create_augroup(group, {})
  vim.api.nvim_create_autocmd(def.event, {
    group = group,
    pattern = def.pattern,
    callback = def.callback,
    command = def.command,
  })
end

local function close_relwin(target_ft)
  local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
    local win_ft = vim.api.nvim_buf_get_option_value(vim.api.nvim_win_get_buf(v), "filetype")

    return vim.api.nvim_win_get_config(v).relative ~= ""
        and v ~= vim.api.nvim_get_current_win()
        and win_ft == target_ft
  end)
  for _, w in ipairs(inactive_floating_wins) do
    pcall(vim.api.nvim_win_close, w, false)
  end
end

local user_commands = {
  LazyClose = { callback = function() close_relwin("lazy") end, opts = nil },
  MasonClose = { callback = function() close_relwin("mason") end, opts = nil },
}

-- nvim_create_user_command({name}, {command}, {*opts})
--     Creates a global |user-commands| command.
--
--     For Lua usage see |lua-guide-commands-create|.
--
--     Example: >vim
--        :call nvim_create_user_command('SayHello', 'echo "Hello world!"', {'bang': v:true})
--        :SayHello
--        Hello world!
-- <
--
--     Parameters:
--       • {name}     Name of the new user command. Must begin with an uppercase
--                    letter.
--       • {command}  Replacement command to execute when this user command is
--                    executed. When called from Lua, the command can also be a
--                    Lua function. The function is called with a single table
--                    argument that contains the following keys:
--                    • name: (string) Command name
--                    • args: (string) The args passed to the command, if any
--                      |<args>|
--                    • fargs: (table) The args split by unescaped whitespace
--                      (when more than one argument is allowed), if any
--                      |<f-args>|
--                    • bang: (boolean) "true" if the command was executed with a
--                      ! modifier |<bang>|
--                    • line1: (number) The starting line of the command range
--                      |<line1>|
--                    • line2: (number) The final line of the command range
--                      |<line2>|
--                    • range: (number) The number of items in the command range:
--                      0, 1, or 2 |<range>|
--                    • count: (number) Any count supplied |<count>|
--                    • reg: (string) The optional register, if specified |<reg>|
--                    • mods: (string) Command modifiers, if any |<mods>|
--                    • smods: (table) Command modifiers in a structured format.
--                      Has the same structure as the "mods" key of
--                      |nvim_parse_cmd()|.
--       • {opts}     Optional |command-attributes|.
--                    • Set boolean attributes such as |:command-bang| or
--                      |:command-bar| to true (but not |:command-buffer|, use
--                      |nvim_buf_create_user_command()| instead).
--                    • "complete" |:command-complete| also accepts a Lua
--                      function which works like
--                      |:command-completion-customlist|.
--                    • Other parameters:
--                      • desc: (string) Used for listing the command when a Lua
--                        function is used for {command}.
--                      • force: (boolean, default true) Override any previous
--                        definition.
--                      • preview: (function) Preview callback for 'inccommand'
--                        |:command-preview|

for cmd, cfg in pairs(user_commands) do
  vim.api.nvim_create_user_command(cmd, cfg.callback, cfg.opts or {})
end
