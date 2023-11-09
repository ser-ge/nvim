-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    --
    --
    use 'wbthomason/packer.nvim'

    use 'vimwiki/vimwiki'

    use 'projekt0n/github-nvim-theme'

    use 'ThePrimeagen/git-worktree.nvim'

    use {
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    }

    use "sindrets/diffview.nvim"

    use 'tpope/vim-commentary'

    use "jpalardy/vim-slime"

    use "ribru17/bamboo.nvim"

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "ellisonleao/gruvbox.nvim" }
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim")
    -- if packer_bootstrap then
    -- require('packer').sync()
    --

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    })


    use { "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        },
        -- keys = {
        --     { "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
        --     { "<leader>dts", ":lua require'neotest'.run.stop()<cr>",                  desc = "stop test" },
        --     { "<leader>dta", ":lua require'neotest'.run.attach()<cr>",                desc = "attach test" },
        --     { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
        --     { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>",            desc = "test summary" },
        -- }

    }

    use { "mfussenegger/nvim-dap",
        requires = { "rcarriga/nvim-dap-ui", 'mfussenegger/nvim-dap-python', 'theHamsta/nvim-dap-virtual-text' },
        -- keys = {
        --     { "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", desc = "debug breakpoint" },
        --     { "<leader>dr", ": lua require'dap'.repl_open()<cr>",        desc = "debug repl" },
        --     { "<leader>du", ": lua require'dapui'.toggle()<cr>",         desc = "debug into" },
        -- },
    }
end)
