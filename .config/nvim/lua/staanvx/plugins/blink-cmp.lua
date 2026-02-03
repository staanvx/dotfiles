require("blink.cmp").setup({
  keymap = {
    preset = 'enter',
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = true },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
    per_filetype = {
      --    sql = { 'dadbod' },
      lua = { inherit_defaults = true, 'lazydev' }
    },
    providers = {
      --   dadbod = { module = "vim_dadbod_completion.blink" },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
    },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
    prebuilt_binaries = { force_version = "v1.7.0" },
  }
})
