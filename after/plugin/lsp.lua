    local lsp = require("lsp-zero")
    local luasnip = require 'luasnip'

    lsp.preset("recommended")

    lsp.ensure_installed({
      'tsserver',
      'rust_analyzer',

    })

    -- Fix Undefined global 'vim'
    lsp.nvim_workspace()


    local cmp = require('cmp')
    local cmp_select = {behavior = cmp.SelectBehavior.Select}


    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
}




vim.api.nvim_set_keymap('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {silent = true, script = true, expr = true})





-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
-- })

--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })
--
require("lsp-format").setup {}


lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  require("lsp-format").on_attach(client, bufnr)

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.skip_server_setup({'rust_analyzer'})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- local venv_path = os.getenv('VIRTUAL_ENV')
-- local py_path = nil
-- -- decide which python executable to use for mypy
-- if venv_path ~= nil then
-- py_path = venv_path .. "/bin/python"
-- vim.g.python3_host_prog = py_path
-- else
-- py_path = vim.g.python3_host_prog
-- end

-- require('mason-lspconfig').setup({
--   handlers = {
--     lsp.default_setup,
--     pylsp = function()
--       require('lspconfig').pylsp.setup({
--         single_file_support = false,
--             pylsp = {
--             overrides = { "--python-executable", py_path, true },
--             plugins = {
--               -- formatter options
--               -- black = { enabled = true },
--               -- autopep8 = { enabled = false },
--               -- yapf = { enabled = false },
--               -- -- linter options
--               -- pylint = { enabled = true, executable = "pylint" },
--               -- ruff = { enabled = false },
--               -- pyflakes = { enabled = false },
--               -- pycodestyle = { enabled = false },
--               -- type checker
--               pylsp_mypy = {
--                 enabled = true,
--                 overrides = { "--python-executable", py_path, true },
--                 report_progress = true,
--                 live_mode = false
--               },
--               -- auto-completion options
--               jedi_completion = { fuzzy = true },
--               jedi = {
--             extra_paths = {py_path}},
--               -- import sorting
--               isort = { enabled = true },
--             },
--           }
--       })
--     end,
--   }
-- })

