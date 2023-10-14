return {
  'creativenull/efmls-configs-nvim',
  version = 'v1.x.x', -- version is optional, but recommended
  dependencies = { 'neovim/nvim-lspconfig' },

  config = function() 
    local flake8 = require('efmls-configs.linters.flake8')
    local autopep8 = require('efmls-configs.formatters.autopep8')
    local eslint_d  = require('efmls-configs.formatters.eslint_d')
    local prettier_d = require('efmls-configs.formatters.prettier_d')

    local languages = {
      python = { flake8, autopep8 },
      typescript =  { eslint_d, prettier_d },
      javascript =  { eslint_d, prettier_d } 
    }


    local efmls_config = {
      filetypes = vim.tbl_keys(languages),
      settings = {
        rootMarkers = { '.git/' },
        languages = languages,
      },
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
      },
    }

    require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {}))

  end 

}
