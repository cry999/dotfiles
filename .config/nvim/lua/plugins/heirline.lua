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
      -- no = "N?",
      -- nov = "N?",
      -- noV = "N?",
      -- ["no\22"] = "N?",
      -- niI = "Ni",
      -- niR = "Nr",
      -- niV = "Nv",
      -- nt = "Nt",
      v = "VISUAL",
      -- vs = "Vs",
      V = "L-VISUAL",
      -- Vs = "Vs",
      ["\22"] = "B-VISUAL",
      ["\22s"] = "B-VISUAL",
      -- s = "S",
      -- S = "S_",
      -- ["\19"] = "^S",
      i = "INSERT",
      -- ic = "Ic",
      -- ix = "Ix",
      R = "REPLACE",
      -- Rc = "Rc",
      -- Rx = "Rx",
      -- Rv = "Rv",
      -- Rvc = "Rv",
      -- Rvx = "Rv",
      c = "COMMAND",
      -- cv = "Ex",
      -- r = "...",
      -- rm = "M",
      -- ["r?"] = "?",
      -- ["!"] = "!",
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
          return self.icon .. " " .. self.tailname
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
  hl = { fg = "magenta" },
  { -- branch name
    provider = function(self) return require("icons").GitBranch .. " " .. self.status_dict.head end,
  },
  { provider = " " },
  {
    condition = function(self) return self.has_changes end,
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (require("icons").GitAdd .. " " .. self.status_dict.added)
    end,
    hl = { fg = "green" },
  },
  {
    condition = function(self) return self.has_changes end,
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (require("icons").GitDelete .. " " .. self.status_dict.removed)
    end,
    hl = { fg = "red" },
  },
  {
    condition = function(self) return self.has_changes end,
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (require("icons").GitChange .. " " .. self.status_dict.changed)
    end,
    hl = { fg = "red" },
  },
}

local Align = { provider = "%=" }

return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
  opts = function()
    return {
      statusline = {
        hl = { bg = "bg" },
        condition = function() return vim.bo.filetype ~= "neo-tree" end,
        { ViModeLeftRounded, ViMode, ViModeRightRounded },
        Separator,
        FileName,
        Separator,
        Diagnostics,
        Align,
        Git,
        Separator,
      },
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local frappe = require("catppuccin.palettes").get_palette("frappe")
    heirline.load_colors({
      bg = frappe.base,
      fg = frappe.text,
      purple = frappe.mauve,
      red = frappe.red,
      magenta = frappe.maroon,
      yellow = frappe.yellow,
      green = frappe.green,
      blue = frappe.blue,
      dark = frappe.dark,
    })
    heirline.setup(opts)
  end,
}
