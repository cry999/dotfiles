vim.opt_local.conceallevel = 3
vim.opt_local.wrap = true

---is_task_line
---@param line string
---@return boolean
local function is_task_line(line)
  return line:find('^%s*%- %[.-%]')
end

---toggle_checkbox toggles the checkbox in the current line
---@param check_char string
---@param togglable? boolean
---@return nil
local function toggle_checkbox(check_char, togglable)
  local line = vim.fn.getline('.')
  if togglable and line:find('^%s*%- %[' .. check_char .. '%]') then
    local new_line = line:gsub('^(%s*)%- %[' .. check_char .. '%]', '%1- [ ]')
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.fn.setline('.', new_line)
    return
  end
  local new_line = line:gsub('^(%s*)%- %[.-%]', '%1- [' .. check_char .. ']')
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.fn.setline('.', new_line)
end

local mappings = {
  n = {
    ['<localleader><localleader>'] = {
      function()
        local line = vim.fn.getline('.')
        if is_task_line(line) then
          local new_line = line:gsub('^(%s*)%- %[.%]%s*', '%1')
          ---@diagnostic disable-next-line: param-type-mismatch
          vim.fn.setline('.', new_line)
        else
          local new_line = line:gsub('^(%s*)', '%1- [ ] ')
          ---@diagnostic disable-next-line: param-type-mismatch
          vim.fn.setline('.', new_line)
        end
      end,
      desc = 'Toggle current line task'
    },
    ['<localleader>x'] = {
      function() toggle_checkbox('x', true) end,
      desc = 'Toggle task done',
    },
    ['<localleader>f'] = {
      function() toggle_checkbox('f', true) end,
      desc = 'Toggle task focused',
    },
    ['<localleader>-'] = {
      function() toggle_checkbox('%-', true) end,
      desc = 'Toggle task canceled',
    },
  },
}

for mode, mappings_in_mode in pairs(mappings) do
  for key, opts in pairs(mappings_in_mode) do
    local rhs = opts[1]
    opts[1] = nil
    opts.buffer = true
    vim.keymap.set(mode, key, rhs, opts)
  end
end
