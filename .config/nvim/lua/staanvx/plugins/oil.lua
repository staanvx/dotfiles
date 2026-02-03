local detail = false

local map = vim.keymap.set

require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,

  columns = {
    "icon",
  },

  win_options = {
    wrap = false,
    signcolumn = "no",
    colorcolumn = "0",
  },

  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },

  keymaps = {
    ["<C-p>"] = "actions.preview",
    ["<leader>e"] = { "actions.close", mode = "n" },
    ["<C-c>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        else
          require("oil").set_columns({ "icon" })
        end
      end,
    },

  },

  float = {
    padding = 2,
    max_width = 0.8,
    max_height = 0.8,
    border = "single",
    preview_split = "right",
  }
})

map("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
