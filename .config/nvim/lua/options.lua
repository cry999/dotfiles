vim.opt.backspace:append { "nostop" }
vim.opt.diffopt:append "linematch:60"

local options = {
  opt = {
    breakindent = true,
    clipboard = "unnamedplus",
    cmdheight = 0,
    completeopt = { "menu", "menuone", "noselect" },
    copyindent = true,
    cursorline = true,
    expandtab = true,
    fileencoding = "utf-8",
    fillchars = { eob = " " },
    foldmethod = "expr",
    foldlevel = 99,
    -- foldcolumn = "1",
    foldlevelstart = 99,
    foldenable = true,
    ignorecase = true,
    infercase = true,
    laststatus = 3,
    linebreak = true,
    mouse = "",
    number = true,
    preserveindent = true,
    pumheight = 10,
    shiftwidth = 2,
    showtabline = 2,
    signcolumn = "yes",
    smartcase = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    timeoutlen = 500,
    undofile = true,
    updatetime = 300,
    virtualedit = "block",
    wrap = false,
    writebackup = false,
  },
  g = {
    mapleader = " ",
    maplocallaeder = ",",
    autoformat_enabled = true,
    autopairs_enabled = true,
    cmp_enabled = true,
    codelens_enabled = true,
    diagnostics_mode = 3,
    highlighturl_enabled = true,
    icons_enabled = true,
    inlay_hints_enabled = false,
    lsp_handlers_enabled = true,
    semantic_tokens_enabled = true,
    ui_notifications_enabled = true,
    git_worktrees = nil,
  },
  t = vim.t.bufs and vim.t.bufs or { bufs = vim.api.nvim_list_bufs() },
}

for scope, settings in pairs(options) do
  for setting, value in pairs(settings) do
    vim[scope][setting] = value
  end
end
