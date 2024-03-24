local telekasten_home = vim.fn.expand('~/.telekasten')

return {
  'renerocksai/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = {
    -- Main paths
    home                        = telekasten_home,                 -- path to main notes folder
    dailies                     = telekasten_home .. '/daily',     -- path to daily notes
    weeklies                    = telekasten_home .. '/weekly',    -- path to weekly notes
    templates                   = telekasten_home .. '/templates', -- path to templates

    -- Specific note templates
    -- set to `nil` or do not specify if you do not want a template
    -- TODO: add support for multiple templates
    -- template_new_note           = '/path/to/file', -- template for new notes
    -- template_new_daily          = '/path/to/file', -- template for new daily notes
    -- template_new_weekly         = '/path/to/file', -- template for new weekly notes

    -- Image subdir for pasting
    -- subdir name
    -- or nil if pasted images shouldn't go into a special subdir
    -- image_subdir                = "img",

    -- File extension for note files
    extension                   = ".md",

    -- Generate note filenames. One of:
    -- "title" (kdefaultk) - Use title if supplied, uuid otherwise
    -- "uuid" - Use uuid
    -- "uuid-title" - Prefix title by uuid
    -- "title-uuid" - Suffix title with uuid
    new_note_filename           = "uuid-title",
    -- file uuid type ("rand" or input for os.date such as "%Y%m%d%H%M")
    uuid_type                   = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep                    = "-",

    -- Flags for creating non-existing notes
    follow_creates_nonexisting  = true, -- create non-existing on follow
    dailies_create_nonexisting  = true, -- create non-existing dailies
    weeklies_create_nonexisting = true, -- create non-existing weeklies

    -- Image link style",
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style            = "wiki",

    -- Default sort option: 'filename', 'modified'
    sort                        = "filename",

    -- Make syntax available to markdown buffers and telescope previewers
    install_syntax              = true,

    -- Tag notation: '#tag', '@tag', ':tag:', 'yaml-bare'
    tag_notation                = "#tag",

    -- When linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links            = true,

    -- Command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme       = "ivy",

    -- Tag list theme:
    -- get_cursor (small tag list at cursor)
    -- dropdown (window)
    -- ivy (bottom panel)
    show_tags_theme             = "ivy",

    -- Previewer for media files (images mostly)
    -- "telescope-media-files" if you have telescope-media-files.nvim installed
    -- "catimg-previewer" if you have catimg installed
    -- "viu-previewer" if you have viu installed
    media_previewer             = "telescope-media-files",

    -- Customize insert image and preview image files list. This is useful
    -- to add optional filetypes into filtered list (for example
    -- telescope-media-files optionally supporting svg preview)
    media_extensions            = {
      ".png",
      ".jpg",
      ".bmp",
      ".gif",
      ".pdf",
      ".mp4",
      ".webm",
      ".webp",
    },

    -- Calendar integration
    plug_into_calendar          = false, -- use calendar integration
    calendar_opts               = {
      weeknm = 4,                        -- calendar week display mode:
      --   1 .. 'WK01'
      --   2 .. 'WK 1'
      --   3 .. 'KW01'
      --   4 .. 'KW 1'
      --   5 .. '1'

      calendar_monday = 1, -- use monday as first day of week:
      --   1 .. true
      --   0 .. false

      calendar_mark = 'left-fit', -- calendar mark placement
      -- where to put mark for marked days:
      --   'left'
      --   'right'
      --   'left-fit'
    },

    vaults                      = {
      personal = {
        -- configuration for personal vault. E.g.:
        -- home = "/home/user/vaults/personal",
      }
    },
  },
}
