-- to configure lsp server
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- to configure lsp autocompletion
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

-- to configure ts lsp server
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

-- setup autocompletion keymaps
local keymap = vim.keymap -- for convenience

-- used to enable autocompletion
local capabilities = cmp_nvim_lsp.default_capabilities()



-- enable keybinds for available lsp server
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
  end
end


-- basedpyright
lspconfig["basedpyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- bash-language-server
lspconfig["bashls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- clang-language-server
lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- csharp language server
lspconfig["csharp_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- css language server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- cssmodules language server
lspconfig["cssmodules_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- docker compose language server
lspconfig["docker_compose_language_service"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- dockerfile language server
lspconfig["dockerls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- erlang elp language server
lspconfig["elp"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- javascript language server
lspconfig["eslint"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- go language server
lspconfig["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- go lang lint language server
lspconfig["golangci_lint_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- gradle language server
lspconfig["gradle_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- grammarly language server
lspconfig["grammarly"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- htmx language server
lspconfig["htmx"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- html language server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- php intelephense language server
lspconfig["intelephense"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- java language server
lspconfig["jdtls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- json language server
lspconfig["jsonls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- kotlin language server
lspconfig["kotlin_language_server"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lua language server
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
	    runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

-- markdown language server
lspconfig["marksman"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- solidity language server
lspconfig["solidity_ls_nomicfoundation"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- php language server
lspconfig["phpactor"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- powershell language server
lspconfig["powershell_es"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- python language server
lspconfig["pylyzer"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- python language server
lspconfig["pyre"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- python language server
lspconfig["pylsp"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- javascript linting language server
lspconfig["quick_lint_js"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- r language server
lspconfig["r_language_server"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- rust analyzer language server
lspconfig["rust_analyzer"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- solidity language server
lspconfig["solang"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- solidity language server
lspconfig["solidity"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- sql language server
lspconfig["sqls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- sql language server
lspconfig["sqlls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- tailwindcss language server
lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- typescript language server
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
})

-- vim language server
lspconfig["vimls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- vscode solidity language server
lspconfig["solidity_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- yaml language server
lspconfig["yamlls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- zk text language server
lspconfig["zk"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- zig language server
lspconfig["zls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

