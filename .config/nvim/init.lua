require('staanvx')

local map = vim.keymap.set


local capabilities = require('blink.cmp').get_lsp_capabilities()

-- LSP
vim.lsp.enable({
  'pyright',
  'lua_ls',
  'sqls',
  'tinymist',
  'zls'
})

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = { diagnostics = { globals = { 'vim' } } },
  },
})

vim.lsp.config('pyright', {
  capabilities = capabilities,
})

-- typst
vim.lsp.config["tinymist"] = {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  capabilities = capabilities,
  root_markers = { '.git' },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable"
  }
}

vim.lsp.config["zls"] = {
  cmd = { "zls" },
  filetypes = { "zig" },
  root_markers = { ".git", "build.zig", "zig.build.zig" },

  capabilities = capabilities,

  settings = {
    zig = {
      zig_exe_path = "/opt/homebrew/bin/zig", -- важно для mac m1 + brew
      enable_inlay_hints = true,
      enable_snippets = true,
      semantic_tokens = true,
    }
  }
}


map('n', '<leader>lf', vim.lsp.buf.format, { desc = "Lsp format current buffer" })


-- Diagnostic Config
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = true },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Float diagnostics" })

map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Prev diagnostic" })

map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Next diagnostic" })

map('n', '<leader>da', vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP code actions" })

-- TODO nvim-treesitter
-- TODO tab navigation
-- TODO sql
-- TODO typst
-- TODO jupyter
-- TODO org???
-- TODO which-key
-- https://github.com/bluz71/nvim-linefly
