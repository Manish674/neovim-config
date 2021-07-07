local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "maintained",
  autotag = {
    enable = true,
    filetypes = { 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'typescript' },
  }
}
