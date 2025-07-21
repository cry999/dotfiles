local M = {}

function M.copilot_chat(query_textobject)
  local function selection()
    local shared = require("nvim-treesitter.textobjects.shared")
    local bufnr, textobject = shared.textobject_at_point(query_textobject, "textobjects")
    ---@diagnostic disable-next-line: param-type-mismatch
    local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(textobject)
    ---@diagnostic disable-next-line: param-type-mismatch
    local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col + 1, {})
    local text = table.concat(lines, "\n")

    if vim.trim(text) == "" then
      return nil
    end
    return {
      lines = text,
      start_row = start_row + 1,
      start_col = start_col + 1,
      end_row = end_row + 1,
      end_col = end_col + 1,
    }
  end

  local input = vim.fn.input("CopilotChat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, {
      selection = selection,
    })
  end
end

return M