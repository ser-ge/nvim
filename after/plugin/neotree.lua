local neotree = require("neo-tree")

neotree.setup({
  close_if_last_window = true,
  name = {
    trailing_slash = true,
    use_git_status_colors = true,
    highlight = "NeoTreeFileName",
  },
  window = {
    width = 50,
  },
  filesystem = {
    follow_current_file = false,
    filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
})
