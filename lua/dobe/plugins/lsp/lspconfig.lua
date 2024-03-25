-- credits to grammenoudis (see: https://github.com/grammenoudis/LazyNvim/blob/main/lua/completion-cmp/init.lua)

-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

mason.setup({
  ui = {icons = {package_installed = "✓", package_pending = "➜", package_uninstalled = "✗"}}
})

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason_lspconfig.setup()

local keymap = vim.keymap
-- keybind options
local opts = { noremap = true, silent = true }
-- require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require 'cmp'
local select_opts = {behavior = cmp.SelectBehavior.Select}
local lspkind = require('lspkind')
cmp.setup({
  experimental = {ghost_text = true},
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- set keybinds
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts), -- show definition, references
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts), -- got to declaration
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts), -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts), -- go to implementation
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts), -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts), -- smart rename
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts), -- show  diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts), -- show diagnostics for cursor
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts), -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts), -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts), -- show documentation for what is under cursor
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
  }),
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, -- { name = 'vsnip' }, -- For vsnip users.
    {name = 'luasnip'} -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {{name = 'buffer'}})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
  }, {{name = 'buffer'}})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'},
                  {mapping = cmp.mapping.preset.cmdline(), sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- capabilities.offsetEncoding = 'utf-8' -- disabled to remove python lsp error
-- See :help mason-lspconfig-dynamic-server-setup
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup {capabilities = capabilities}
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      settings = {completions = {completeFunctionCalls = true}},
      on_attach = function(client, bufnr)
        -- typescript specific keymaps (e.g. rename file and update imports)
        if client.name == "tsserver" then
          keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", { buffer = bufnr }) -- rename file and update imports
          keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", { buffer = bufnr }) -- organize imports (not in youtube nvim video)
          keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", { buffer = bufnr }) -- remove unused variables (not in youtube nvim video)
        end
      end
    })
  end
})
