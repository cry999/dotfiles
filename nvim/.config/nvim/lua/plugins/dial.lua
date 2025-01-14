return {
  -- better increment/decrement
  "monaqa/dial.nvim",
  config = function()
    local augend = require("dial.augend")
    require('dial.config').augends:register_group({
      default = {
        augend.case.new({ types = { "camelCase", "snake_case", "PascalCase" }, cyclic = true }),
        augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "&&", "||" }, word = false }),
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.semver.alias.semver,
        augend.constant.alias.bool,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.new({ pattern = "%Y-%m-%d(%a)", default_kind = 'day', only_valid = false }),
        augend.date.new({ pattern = "%Y-%m-%d(%A)", default_kind = 'day', only_valid = false }),
        augend.date.new({ pattern = "%Y年%-m月%-d日(%a)", default_kind = 'day', only_valid = false }),
        augend.date.new({ pattern = "%Y年%-m月%-d日(%A)", default_kind = 'day', only_valid = false }),
        augend.date.new({ pattern = "%Y年%-m月%-d日(%J)", default_kind = "day", only_valid = false }),
        augend.date.new({ pattern = "%Y年%-m月%-d日", default_kind = 'day', only_valid = false }),
      },
      golang = {
        augend.constant.new({ elements = { ":=", "=" }, word = true }),
      },
      javascript = {
        augend.constant.new({ elements = { "let", "const" }, word = true, cyclic = true, match_before_cursor = true }),
      },
    })
  end,
}
