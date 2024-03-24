local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "tsserver", -- typescript core
    "html", -- html core
    "cssls", -- css core
    "tailwindcss", -- tailwind core
    "sumneko_lua", -- lua core
    -- custom below
    "arduino_language_server", -- Arduino core
    "autopep8", -- python style
    "basedpyright", -- python core
    "bash_debug_adapter", -- bash debug
    "bashls", -- bash core
    "blade_formatter", -- laravel style
    "black", -- python style
    "checkstyle", -- java style
    "clang_format", -- C language style
    "clangd", -- C language compiler core
    "cobol_ls",
    "csharp_ls",
    "cpptools",
    "css_variables", -- css core
    "cssmodules_ls", -- css core
    "debugpy", -- python debug
    "docker_compose_language_service", -- docker core
    "dockerls", -- docker core
    "erlangls",
    "eslint", -- javascript core
    "html_beautifier", -- html formatter
    "htmlhint", -- html linter
    "ktlint", -- kotlin linter
    -- "gdscript",
    -- "glsl_analyzer", -- opengl core
    -- "glslls", -- opengl core
    "golangci_lint_ls",
    "gopls",
    "gradle_ls",
    "grammarly",
    "htmx",
    "hsl", -- haskell core
    "intelephense", -- php core
    "java_language_server", -- java core
    "java_test", --java debug
    "jdtls", -- java core
    "js_debug_adapter", -- javascript debug
    "jsonnetfmt", -- json formatter
    "jsonlint", -- json linter
    "jsonls", -- json core
    "kotlin_debug_adapter", -- kotlin debug
    "kotlin_language_server", -- kotlin jvm core
    "lua_ls", -- lua core
    "markdownlint", -- markdown linter
    "marksman", -- markdown core
    -- "perlls",
    -- "perlnavigator",
    -- "perlpls",
    "phpstan", -- php linter
    "phan", -- php core
    "php_debug_adapter", -- php debug
    "phpactor", -- php core
    "phpmd", -- php markdown
    -- "postgres_lsp",
    "pretty-php", -- php formatter
    "php_cs_fixer", -- php debug
    "prettier", -- javascript formatter
    "powershell_es", -- powershell core
    "pylint", -- python linter
    "pylsp", -- python core
    "pylyzer", -- python core
    "pyre", -- python core
    "pyright", -- python core
    "quick_lint_js", -- javascript core
    "r_language_server", -- r core
    -- "ruby_ls",
    "rust_analyzer",
    -- "salt_ls",
    -- "solargraph", -- ruby core
    "solang", -- solidity core
    "solidity",
    "solidity_ls",
    "solidity_ls_nomicfoundation",
    "sourcekit", -- C, C++, Objective-C, Swift core
    "sqlls", -- sql core
    "sqls", -- sql core
    "stylua", -- lua style
    -- "svelte",
    -- "svlangserver",
    -- "svls",
    "ts_standard", -- typescript style
    "vscode_java_decompiler", -- java helper
    "vimls", -- vim core
    "xmlformatter", -- xml formatter
    "yamlfix", -- yaml debug
    "yamlfmt", -- yaml formatter
    "yamlls", -- yaml core
    "zk", -- zk plaintext core
    "zls", -- zig core
  }  
})

