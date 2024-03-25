-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

-- for conciseness
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  -- setup formatters and linters
  sources = {
    -- formatters
    formatting.prettier.with({                        -- for js, ts, css
      condition = function(utils)
        return utils.root_has_file(".prettierrc") or
               utils.root_has_file(".prettierrc.js") or
               utils.root_has_file(".prettierrc.json") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    formatting.stylua.with({                          -- for lua
      condition = function(utils)
        return utils.root_has_file("stylua.toml") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    formatting.ktlint.with({                          -- for kotlin
      condition = function(utils)
        return utils.root_has_file(".ktlintrc") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    formatting.sqlfluff.with({                        -- for sql
      condition = function(utils)
        return utils.root_has_file(".sqlfluff") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),

    -- diagnostics
    diagnostics.eslint_d.with({                       -- for js, jsx
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or
               utils.root_has_file(".eslintrc.json") or
               false -- fallback to false to only use if config file present
      end,
    }),
    diagnostics.golangci_lint.with({                  -- for golang
      condition = function(utils)
        return utils.root_has_file(".golangci.yml") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    diagnostics.jsonlint.with({                       -- for json
      condition = function(utils)
        return utils.root_has_file(".jsonlintrc") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    diagnostics.markdownlint.with({                   -- for markdown
      condition = function(utils)
        return utils.root_has_file(".markdownlint.json") or
               utils.root_has_file(".markdownlint.yaml") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    diagnostics.phpstan.with({                        -- for php
      condition = function(utils)
        return utils.root_has_file("phpstan.neon") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    diagnostics.pylint.with({                         -- for python
      condition = function(utils)
        return utils.root_has_file(".pylintrc") or
               utils.root_has_file("pyproject.toml") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    diagnostics.solhint.with({                        -- for solidity
      condition = function(utils)
        return utils.root_has_file(".solhint.json") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    diagnostics.yamllint.with({                       -- for yaml
      condition = function(utils)
        return utils.root_has_file(".yamllint") or
               true -- fallback to true to use default settings on save. False to disable
      end,
    }),
    -- Add other diagnostics/formatters as needed...
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
