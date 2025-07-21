-- Modular key mappings
-- This file loads and applies all key mappings from separate category files

local M = {}

-- Load all mapping modules
local mapping_modules = {
  "mappings.window",    -- Window and tab management
  "mappings.lsp",       -- LSP related mappings
  "mappings.telescope", -- Telescope fuzzy finder
  "mappings.git",       -- Git operations
  "mappings.copilot",   -- AI/Copilot features
  "mappings.editor",    -- Basic editing functions
  "mappings.plugins",   -- Other plugin-specific mappings
}

-- Function to apply mappings from a module
local function apply_mappings(module_mappings)
  if not module_mappings or not module_mappings.mappings then
    return
  end

  for mode, mappings in pairs(module_mappings.mappings) do
    for key, mapping in pairs(mappings) do
      local opts = { desc = mapping.desc or "" }
      if mapping[2] then
        opts = vim.tbl_extend("force", opts, mapping[2])
      end
      vim.keymap.set(mode, key, mapping[1], opts)
    end
  end
end

-- Load and apply all mappings
for _, module_name in ipairs(mapping_modules) do
  local ok, module = pcall(require, module_name)
  if ok then
    apply_mappings(module)
  else
    vim.notify("Failed to load mapping module: " .. module_name, vim.log.levels.WARN)
  end
end

-- Which-key setup for better key documentation
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>c", group = "Copilot" },
    { "<leader>f", group = "Find" },
    { "<leader>fl", group = "LSP" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Package" },
    { "<leader>P", group = "Profiler" },
    { "<leader>q", group = "Quit" },
    { "<leader>s", group = "Source/Snacks" },
    { "<leader>t", group = "Terminal" },
    { "<leader>w", group = "Window" },
  })
end

return M