local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "tsserver", -- typescript core
    "html", -- html core
    "cssls", -- css core
    "tailwindcss", -- tailwind core
    -- "sumneko_lua", -- lua core
    -- custom below
    "arduino_language_server", -- Arduino core
    -- "autopep8", -- python style
    "basedpyright", -- python core
    -- "bash_debug_adapter", -- bash debug
    "bashls", -- bash core
    -- "blade_formatter", -- laravel style
    -- "clang_format", -- C language stylei TODO: resolve possible pathing error
    "clangd", -- C language compiler core
    -- "cobol_ls", -- TODO: resolve possible pathing error
    "csharp_ls",
    "cssmodules_ls", -- css core
    "docker_compose_language_service", -- docker core
    "dockerls", -- docker core
    "elp", -- erlang core 
    "eslint", -- javascript core
    -- "gdscript",
    -- "glsl_analyzer", -- opengl core
    -- "glslls", -- opengl core
    "golangci_lint_ls",
    "gopls",
    "gradle_ls",
    "grammarly",
    "htmx",
    -- "hls", -- haskell core TODO: resolve possible pathing error
    "intelephense", -- php core
    "jdtls", -- java core
    "jsonls", -- json core
    "kotlin_language_server", -- kotlin jvm core
    "lua_ls", -- lua core
    "marksman", -- markdown core
    -- "perlls",
    -- "perlnavigator",
    -- "perlpls",
    "phpactor", -- php core
    -- "postgres_lsp",
    "powershell_es", -- powershell core
    "pylsp", -- python core
    "pylyzer", -- python core
    "pyre", -- python core
    "quick_lint_js", -- javascript core
    "r_language_server", -- r core
    -- "ruby_ls",
    "rust_analyzer",
    "solang", -- solidity core
    "solidity",
    "solidity_ls",
    "solidity_ls_nomicfoundation",
    -- "sourcekit", -- C, C++, Objective-C, Swift core
    "sqlls", -- sql core
    -- "svelte",
    -- "svlangserver",
    -- "svls",
    "vimls", -- vim core
    "yamlls", -- yaml core
    "zk", -- zk plaintext core
    "zls", -- zig core
  }  
})

mason_null_ls.setup({
  "prettier", -- js, ts, css linter
  "stylua", -- lua linter
  "checkstyle", -- java linter
  "eslint_d", -- js, jsx linter
  "golangci_lint", -- golang linter
  "ktlint", -- kotlin linter
  "jsonlint", -- json linter
  "markdownlint", -- markdown linter
  "phpstan", -- php linter
  "pylint", -- python linter by flake8 devs
  "solhint", -- solidity linter
  "sqlfluff", -- sql linter
  "yamllint", -- yaml linter
})

