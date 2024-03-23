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
      if vim.lsp.inlay_hint ~= nil and not vim.lsp.inlay_hint.is_enabled(args.buf) then
        vim.lsp.inlay_hint.enable(args.buf, true)
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
