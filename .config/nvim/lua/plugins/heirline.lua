local mode_colors = {
  n = "blue",
  i = "green",
  v = "purple",
  V = "purple",
  ["\22"] = "purple",
  c = "orange",
  s = "purple",
  S = "purple",
  -- ["\19"] = "purple",
  R = "red",
  r = "red",
  -- ["!"] = "red",
  t = "magenta",
}

local get_hl = function(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

local Separator = { provider = "  " }

local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "NORMAL",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "VISUAL",
      vs = "Vs",
      V = "L-VISUAL",
      Vs = "Vs",
      ["\22"] = "B-VISUAL",
      ["\22s"] = "B-VISUAL",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "INSERT",
      ic = "Ic",
      ix = "Ix",
      R = "REPLACE",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "COMMAND",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "TERMINAL",
    },
    mode_colors = mode_colors,
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    return " %8(" .. self.mode_names[self.mode] .. "%)"
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = "bg", bg = self.mode_colors[mode], bold = true, }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function(self)
      vim.cmd("redrawstatus")
    end),
  },
}

local ViModeLeftRounded = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  provider = function() return "" end,
  static = {
    mode_colors = mode_colors,
  },
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode], bg = "bg", bold = true, }
  end,
}

local ViModeRightRounded = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  provider = function() return "" end,
  static = {
    mode_colors = mode_colors,
  },
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode], bg = "bg", bold = true, }
  end,
}

local FileName = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
    if self.filename == "" then
      self.filename = "[No Name]"
      self.tailname = "[No Name]"
    else
      self.filename = vim.fn.fnamemodify(self.filename, ":.")
      self.tailname = vim.fn.fnamemodify(self.filename, ":t")
    end
    self.icon, self.icon_color =
        require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo.filetype, { default = true })
  end,
  {
    flexible = true,
    hl = function(self) return { fg = self.icon_color, bg = "bg" } end,
    {
      provider = function(self)
        if vim.bo.filetype == "help" then
          return "HELP " .. self.tailname
        end
        return self.icon .. " " .. self.filename
      end,
    },
    {
      provider = function(self) return self.icon .. " " .. self.tailname end,
    },
  },
}

local Diagnostics = {
  static = {
    signs = {
      Error = require("icons").DiagnosticError,
      Warn = require("icons").DiagnosticWarn,
      Info = require("icons").DiagnosticInfo,
      Hint = require("icons").DiagnosticHint,
    },
  },
  init = function(self)
    self.show = function(severity)
      return self[severity] > 0 and (self.signs[severity] .. " " .. self[severity])
    end
    self.hl_fn = function(severity) return self.sign_colors[severity] end
    for severity, _ in pairs(self.signs) do
      self[severity] = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[string.upper(severity)] })
    end
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  { provider = function(self) return self.show("Error") end, hl = { fg = "red" } },
  { provider = " " },
  { provider = function(self) return self.show("Warn") end,  hl = { fg = "yellow" } },
  { provider = " " },
  { provider = function(self) return self.show("Info") end,  hl = { fg = "blue" } },
  { provider = " " },
  { provider = function(self) return self.show("Hint") end,  hl = { fg = "green" } },
}

local Git = {
  condition = function()
    return require("heirline.conditions").is_git_repo and vim.b.gitsigns_status_dict
  end,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes =
        self.status_dict and
        self.status_dict.added ~= 0 or
        self.status_dict.removed ~= 0 or
        self.status_dict.changed ~= 0
  end,
  {
    { -- branch name
      provider = function(self) return require("icons").GitBranch .. " " .. self.status_dict.head end,
      hl = { fg = "magenta" },
    },
    {
      {
        condition = function(self) return self.has_changes end,
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and (" " .. require("icons").GitAdd .. " " .. self.status_dict.added)
        end,
        hl = { fg = "green" },
      },
      {
        condition = function(self) return self.has_changes end,
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and (" " .. require("icons").GitDelete .. " " .. self.status_dict.removed)
        end,
        hl = { fg = "red" },
      },
      {
        condition = function(self) return self.has_changes end,
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and (" " .. require("icons").GitChange .. " " .. self.status_dict.changed)
        end,
        hl = { fg = "red" },
      },
    },
  },
}

local MacroRec = {
  condition = function(self)
    self.reg = vim.fn.reg_recording()
    return vim.fn.reg_recording() ~= ""
  end,
  provider = function(self)
    return require("icons").MacroRecording .. " " .. self.reg
  end,
  hl = { fg = "orange", bold = true },
  update = {
    "RecordingEnter",
    "RecordingLeave",
  }
}

local TablineFileName = {
  provider = function(self)
    print("filename:", self.filename)
    if self.filename == "" then
      return "[No Name]"
    else
      return vim.fn.fnamemodify(self.filename, ":t")
    end
  end,
  hl = function(self) return self.is_active and "TabLineSel" or "TabLine" end,
}

local TablineFileFlags = {
  { -- modified
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    provider = function()
      return require("icons").FileModified .. " "
    end,
    hl = { fg = "green" },
  },
  { -- read-only
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    end,
    provider = function(self)
      return require("icons").FileReadOnly .. " "
    end,
    hl = { fg = "red" },
  },
}

local FileActive = {
  provider = function(self) return self.is_active and require("icons").GitSign or " " end,
  hl = { fg = "blue", bg = "bg" },
}

local FileIcon = {
  init = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    local ext = vim.fn.fnamemodify(self.filename, ":e")
    self.icon, self.icon_color =
        require("nvim-web-devicons").get_icon_color(filename, ext)
    if not self.icon then self.icon = "" end
    if not self.icon_color then self.icon_color = get_hl("TabLine").fg end
  end,
  provider = function(self) return self.icon and (" " .. self.icon .. " ") or "" end,
  hl = function(self) return { fg = self.icon_color } end,
}

local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    return self.is_active and "TabLineSel" or "TabLine"
  end,
  FileIcon,
  TablineFileName,
  Separator,
  TablineFileFlags,
}

local TablineExplorer = {
  condition = function(self)
    self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(self.winid)
    return vim.bo[bufnr or 0].filetype == "neo-tree"
  end,
  provider = function(self)
    local width = vim.api.nvim_win_get_width(self.winid) + 1
    local lb = string.rep(" ", (width - 1) / 2)
    local rb = string.rep(" ", (width - 1) / 2)
    if width - 1 % 2 then
      lb = lb .. " "
    end
    return lb .. require("icons").Tree .. rb
  end,
}

local TablineBufferBlock = {
  FileActive, TablineFileNameBlock,
}

local NavicWinbar = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  provider = function()
    return require("nvim-navic").get_location()
  end,
  hl = { bg = "bg" },
}

local FileNameWinbar = {
  condition = function()
    local filename = vim.api.nvim_buf_get_name(0)
    local term = "term://"
    local neotree = "neo-tree filesystem"
    return string.sub(filename, 1, string.len(term)) ~= term
        and string.sub(vim.fn.fnamemodify(filename, ":t"), 1, string.len(neotree)) ~= neotree
  end,
  init = function(self)
    self.tailname = vim.api.nvim_buf_get_name(0)
    if self.filename == "" then
      self.tailname = "[No Name]"
    else
      self.tailname = vim.fn.fnamemodify(self.tailname, ":t")
    end
    self.icon, self.icon_color =
        require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo.filetype, { default = true })
  end,
  {
    hl = function(self) return { bg = self.icon_color, fg = "bg" } end,
    provider = function(self)
      if vim.bo.filetype == "help" then
        return " HELP " .. self.tailname .. " "
      end
      return " " .. self.icon .. " " .. self.tailname .. " "
    end,
  },
  {
    hl = function(self) return { fg = self.icon_color, bg = "bg" } end,
    provider = ""
  },
  Separator,
}

local Align = { provider = "%=" }

return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
  opts = function()
    local utils = require("heirline.utils")
    return {
      statusline = {
        hl = { bg = "bg" },
        condition = function() return vim.bo.filetype ~= "neo-tree" end,
        { ViModeLeftRounded, ViMode, ViModeRightRounded },
        Separator,
        FileName,
        Separator,
        Diagnostics,
        Separator,
        MacroRec,
        Align,
        Git,
        Separator,
      },
      winbar = {
        FileNameWinbar,
        NavicWinbar,
      },
      tabline = {
        TablineExplorer,
        utils.make_buflist(
          TablineBufferBlock,
          { provider = "", hl = { fg = "lavender" } },
          { provider = "", hl = { fg = "lavender" } }
        ),
      },
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local C = require("catppuccin.palettes").get_palette("frappe")
    -- local brighten = require("catppuccin.utils.colors").brighten
    -- local darken = require("catppuccin.utils.colors").darken

    local highlights = {
      --[[
    local Normal = { fg = C.fg, bg = C.base }
    local Comment = { fg = brighten(C.subtext1, 0.5), bg = C.base }
    local Error = { fg = C.red, bg = C.base }
    local StatusLine = { fg = C.fg, bg = C.mantle }
    ]]
      TabLine = { fg = C.surface2, bg = C.base },
      TabLineFill = { fg = C.fg, bg = C.mantle },
      TabLineSel = { fg = C.fg, bg = C.base, italic = true },
      WinBar = { fg = C.fg, bg = C.base }
      --[[
    local WinBarNC = get_hlgroup("WinBarNC", { fg = C.grey, bg = C.base })
    local Conditional = get_hlgroup("Conditional", { fg = C.bright_purple, bg = C.mantle })
    local String = get_hlgroup("String", { fg = C.green, bg = C.mantle })
    local TypeDef = get_hlgroup("TypeDef", { fg = C.yellow, bg = C.mantle })
    local GitSignsAdd = get_hlgroup("GitSignsAdd", { fg = C.green, bg = C.mantle })
    local GitSignsChange = get_hlgroup("GitSignsChange", { fg = C.orange, bg = C.mantle })
    local GitSignsDelete = get_hlgroup("GitSignsDelete", { fg = C.bright_red, bg = C.mantle })
    local DiagnosticError = get_hlgroup("DiagnosticError", { fg = C.bright_red, bg = C.mantle })
    local DiagnosticWarn = get_hlgroup("DiagnosticWarn", { fg = C.orange, bg = C.mantle })
    local DiagnosticInfo = get_hlgroup("DiagnosticInfo", { fg = C.white, bg = C.mantle })
    local DiagnosticHint = get_hlgroup("DiagnosticHint", { fg = C.bright_yellow, bg = C.mantle })
    local HeirlineInactive = resolve_lualine(get_hlgroup("HeirlineInactive", { bg = nil }).bg, "inactive", C.dark_grey)
    local HeirlineNormal = resolve_lualine(get_hlgroup("HeirlineNormal", { bg = nil }).bg, "normal", C.blue)
    local HeirlineInsert = resolve_lualine(get_hlgroup("HeirlineInsert", { bg = nil }).bg, "insert", C.green)
    local HeirlineVisual = resolve_lualine(get_hlgroup("HeirlineVisual", { bg = nil }).bg, "visual", C.purple)
    local HeirlineReplace = resolve_lualine(get_hlgroup("HeirlineReplace", { bg = nil }).bg, "replace", C.bright_red)
    local HeirlineCommand = resolve_lualine(get_hlgroup("HeirlineCommand", { bg = nil }).bg, "command", C.bright_yellow)
    local HeirlineTerminal = resolve_lualine(get_hlgroup("HeirlineTerminal", { bg = nil }).bg, "insert", HeirlineInsert)
]]
    }

    for name, val in pairs(highlights) do
      vim.api.nvim_set_hl(0, name, val)
    end

    heirline.load_colors({
      bg = C.base,
      fg = C.text,
      dark_bg = C.dark,
      purple = C.mauve,
      red = C.red,
      magenta = C.maroon,
      yellow = C.yellow,
      green = C.green,
      blue = C.blue,
      lavender = C.lavender,

      rosewater = C.rosewater,
      flamingo = C.flamingo,
      pink = C.pink,
      mauve = C.mauve,
      maroon = C.maroon,
      peach = C.peach,
      teal = C.teal,
      sky = C.sky,
      sapphire = C.sapphire,
      text = C.text,
      subtext1 = C.subtext1,
      subtext0 = C.subtext0,
      overlay2 = C.overlay2,
      overlay1 = C.overlay1,
      overlay0 = C.overlay0,
      surface2 = C.surface2,
      surface1 = C.surface1,
      surface0 = C.surface0,
      base = C.base,
      mantle = C.mantle,
      crust = C.crust,
    })
    heirline.setup(opts)
  end,
}
