local function menu_handler(data)
  vim.notify("Menu handler called", vim.log.levels.INFO)
  local options = {}
  local options_by_label = {}

  for _, item in ipairs(data.items) do
    if item.key and item.label:lower() ~= "quit" then
      table.insert(options, item.label)
      options_by_label[item.label] = item
    end
  end
  vim.notify("Options: " .. vim.inspect(options), vim.log.levels.INFO)

  local on_choice = function(choice)
    if not choice then return end

    local option = options_by_label[choice]
    if option.action then
      option.action()
    end
  end

  vim.ui.select(options, { prompt = data.prompt }, on_choice)
end

return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    opts = {
      org_agenda_files = '~/orgfiles/**/*.org',
      org_default_notes_file = '~/orgfiles/refile.org',
      org_startup_folded = 'inherit',
      ui = {
        menu = {
          handler = menu_handler,
        },
        input = {
          use_vim_ui = true,
        },
      },
    },
  },
  {
    "nvim-orgmode/org-bullets.nvim",
    dependencies = { "nvim-orgmode/orgmode" },
    opts = {
      concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
      symbols = {
        -- list symbol
        list = "•",
        -- -- headlines can be a list
        -- -- or a function that receives the defaults and returns a list
        -- headlines = function(default_list)
        --   table.insert(default_list, "♥")
        --   return default_list
        -- end,
        -- -- or false to disable the symbol. Works for all symbols
        -- headlines = false,
        -- -- or a table of tables that provide a name
        -- -- and (optional) highlight group for each headline level
        -- headlines = {
        --   { "◉", "MyBulletL1" }
        --   { "○", "MyBulletL2" },
        --   { "✸", "MyBulletL3" },
        --   { "✿", "MyBulletL4" },
        -- },
        -- headlines = { "◉", "○", "✸", "✿" },
        headlines = { '▋ ' },
        checkboxes = {
          half = { "", "@org.checkbox.halfchecked" },
          done = { "✓", "@org.keyword.done" },
          todo = { " ", "@org.keyword.todo" },
        },
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    dependencies = { "nvim-orgmode/orgmode" },
    opts = {
      directory = "~/orgfiles/roam/",
      -- optional
      org_files = {
        "~/orgfiles/**/*.org",
      }
    },
  },
}
