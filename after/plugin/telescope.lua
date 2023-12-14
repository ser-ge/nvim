local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
--
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


-- builtin.load_extension("git_worktree")
require("telescope").load_extension("git_worktree")
vim.keymap.set("n", "<leader>gl", function() require("telescope").extensions.git_worktree.git_worktrees() end)
vim.keymap.set("n", "<leader>gn", function() require("telescope").extensions.git_worktree.create_git_worktree() end)

