require("neotest").setup {
    adapters = {
        require("neotest-python"), },

}

vim.keymap.set("n", "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>")


    -- keys = {
    --     {  desc = "test" },
    --     { "<leader>dts", ":lua require'neotest'.run.stop()<cr>",                  desc = "stop test" },
    --     { "<leader>dta", ":lua require'neotest'.run.attach()<cr>",                desc = "attach test" },
    --     { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
    --     { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>",            desc = "test summary" },
    -- }
