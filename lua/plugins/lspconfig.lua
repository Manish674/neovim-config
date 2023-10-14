return {
    "neovim/nvim-lspconfig",

    config = function() 
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      
      lspconfig.tsserver.setup {
        capabilities = capabilities
      }

      lspconfig.pyright.setup {
        capabilities = capabilities
      }

      lspconfig.rust_analyzer.setup {
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ['rust-analyzer'] = {},
        },
        capabilities = capabilities
      }

    end
}

