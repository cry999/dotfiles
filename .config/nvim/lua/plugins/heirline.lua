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
      nt = "T-NORMAL",
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
    callback = vim.schedule_wrap(function()
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
    if vim.bo and vim.bo.filetype == "help" then
      self.filename = self.tailname
      self.icon, self.icon_color = require("icons").Help, "mauve"
    else
      self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo.filetype, { default = true })
    end
  end,
  {
    flexible = true,
    hl = function(self) return { fg = self.icon_color, bg = "bg" } end,
    {
      provider = function(self)
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
    provider = function()
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

local TablineTabNumber = {
  init = function(self)
    self.tabnr = vim.api.nvim_tabpage_get_number(0)
  end,
  provider = function(self)
    local icons = require("icons")
    return " " .. icons.Tab .. " " .. self.tabnr .. " "
  end,
  hl = { fg = "base", bg = "lavender" },
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

local has_prefix = function(str, prefix)
  return str:sub(1, #prefix) == prefix
end

local FileNameWinbar = {
  static = {
    plugins = {
      lazy = true,
      mason = true,
    },
  },
  condition = function()
    local filename = vim.api.nvim_buf_get_name(0)
    local term = "term://"
    local neotree = "neo-tree filesystem"
    return not has_prefix(filename, term)
        and not has_prefix(vim.fn.fnamemodify(filename, ":t"), neotree)
        and vim.bo.filetype ~= "alpha"
        and vim.bo.filetype ~= "TelescopePrompt"
        and vim.bo.filetype ~= "chatgpt-input"
  end,
  init = function(self)
    self.tailname = vim.api.nvim_buf_get_name(0)
    if self.tailname == "" then
      self.tailname = "[No Name]"
    else
      self.tailname = vim.fn.fnamemodify(self.tailname, ":t")
    end
    if vim.bo.filetype == "help" then
      self.icon, self.icon_color = require("icons").Help, "mauve"
    elseif self.plugins[vim.bo.filetype] then
      self.tailname = vim.bo.filetype
      self.icon, self.icon_color = require("icons").Plugin, "mauve"
    else
      self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo.filetype, { default = true })
    end
  end,
  {
    hl = function(self) return { bg = self.icon_color, fg = "bg" } end,
    provider = function(self)
      return " " .. self.icon .. " " .. self.tailname .. " "
    end,
  },
  {
    hl = function(self)
      return {
        fg = self.icon_color,
        bg = (require("catppuccin").options.transparent_background and nil) or "bg"
      }
    end,
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
    local conditions = require("heirline.conditions")
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
        TablineTabNumber,
        utils.make_buflist(
          TablineBufferBlock,
          { provider = "", hl = { fg = "lavender" } },
          { provider = "", hl = { fg = "lavender" } }
        ),
      },
      opts = {
        disable_winbar_cb = function()
          return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
          })
        end,
      },
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local C = require("catppuccin.palettes").get_palette()

    heirline.load_colors({
      bg = C.base,
      fg = C.text,
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
