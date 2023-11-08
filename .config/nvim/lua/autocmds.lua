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
