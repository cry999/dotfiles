local groupName = "lua"

vim.api.nvim_create_augroup(groupName, {})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = groupName,
  pattern = { "*.dsl" },
  callback = function() vim.o.expandtab = false end,
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
  group = groupName,
  pattern = { "*.dsl" },
})
