return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  opts = function()
    local dashboard = require("alpha.themes.theta")

    dashboard.header.opts = {
      position = "center",
      hl = {
        { { "RainbowRed", 0, 45 }, { "RainbowBlue", 45, 45 }, { "RainbowOrange", 45, 45 }, { "RainbowBlue", 45, 45 }, { "RainbowYellow", 45, 45 },  { "RainbowGreen", 45, 45 },   { "RainbowCyan", 45, 65 },   { "RainbowViolet", 65, -1 }, },
        { { "RainbowRed", 0, 50 }, { "RainbowBlue", 50, 50 }, { "RainbowOrange", 50, 50 }, { "RainbowBlue", 50, 50 }, { "RainbowYellow", 50, 50 },  { "RainbowGreen", 50, 82 },   { "RainbowBlue", 82, 102 },  { "RainbowViolet", 102, -1 }, },
        { { "RainbowRed", 0, 49 }, { "RainbowBlue", 49, 49 }, { "RainbowOrange", 49, 64 }, { "RainbowBlue", 64, 64 }, { "RainbowYellow", 64, 64 },  { "RainbowGreen", 64, 88 },   { "RainbowCyan", 88, 108 },  { "RainbowViolet", 108, -1 }, },
        { { "RainbowRed", 0, 45 }, { "RainbowBlue", 45, 46 }, { "RainbowOrange", 46, 76 }, { "RainbowBlue", 76, 76 }, { "RainbowYellow", 76, 91 },  { "RainbowGreen", 91, 120 },  { "RainbowCyan", 120, 135 }, { "RainbowViolet", 135, -1 }, },
        { { "RainbowRed", 0, 44 }, { "RainbowBlue", 44, 44 }, { "RainbowOrange", 44, 78 }, { "RainbowBlue", 78, 78 }, { "RainbowYellow", 78, 96 },  { "RainbowGreen", 96, 122 },  { "RainbowCyan", 122, 137 }, { "RainbowViolet", 137, -1 }, },
        { { "RainbowRed", 0, 43 }, { "RainbowBlue", 43, 43 }, { "RainbowOrange", 43, 64 }, { "RainbowBlue", 64, 74 }, { "RainbowYellow", 74, 101 }, { "RainbowGreen", 101, 126 }, { "RainbowCyan", 126, 141 }, { "RainbowViolet", 141, -1 }, },
        { { "RainbowRed", 0, 45 }, { "RainbowBlue", 45, 45 }, { "RainbowOrange", 45, 77 }, { "RainbowBlue", 77, 77 }, { "RainbowYellow", 77, 108 }, { "RainbowGreen", 108, 129 }, { "RainbowCyan", 129, 146 }, { "RainbowViolet", 146, -1 }, },
        { { "RainbowRed", 0, 43 }, { "RainbowBlue", 43, 43 }, { "RainbowOrange", 43, 73 }, { "RainbowBlue", 73, 73 }, { "RainbowYellow", 73, 104 }, { "RainbowGreen", 104, 124 }, { "RainbowCyan", 124, 139 }, { "RainbowViolet", 139, -1 }, },
        { { "RainbowBlue", 0, -1 } },
      },
    }
    dashboard.header.val = {
      [[                                              ██                    ]],
      [[       ███████████           █████      ██                    ]],
      [[      ███████████             █████                            ]],
      [[      ████████████████ ███████████ ███   ███████    ]],
      [[     ████████████████ ████████████ █████ ██████████████  ]],
      [[    █████████████████████████████ █████ █████ ████ █████  ]],
      [[  ██████████████████████████████████ █████ █████ ████ █████ ]],
      [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████]],
      [[ ██████   ██  ███████████████   ██ █████████████████]],
    }

    return dashboard.config
  end,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
}
