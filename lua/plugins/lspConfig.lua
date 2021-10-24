local nvim_lsp = require("lspconfig")
local mappings = require("plugins/lspMappings")
local is_cfg_present = require("utils").is_cfg_present

require("plugins/lspDiagnostic")
require("lspsaga").init_lsp_saga({
  border_style = 1,
})

local custom_on_attach = function(client)
  mappings.lsp_mappings()

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

local custom_on_init = function()
  print("Language Server Protocol started!")
end

local custom_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

-- use eslint if the eslint config file present
local is_using_eslint = function(_, _, result, client_id)
  if is_cfg_present("/.eslintrc.json") or is_cfg_present("/.eslintrc.js") then
    return
  end

  return vim.lsp.handlers["textDocument/publishDiagnostics"](_, _, result, client_id)
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
}

local prettier = {
  formatCommand = "prettier --stdin --stdin-filepath ${INPUT}",
  formatStdin = true,
}


local denofmt = {
  formatCommand = "cat ${INPUT} | deno fmt -",
  formatStdin = true,
}

local sumneko_root = os.getenv("HOME") .. "/repos/lua-language-server"
local servers = {
  tsserver = {
    filetypes = { "javascript", "javascriptreact" , "typescript", "typescriptreact" },
    on_attach = function(client)
      mappings.lsp_mappings()

      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      client.resolved_capabilities.document_formatting = false
    end,
    init_options = {
      documentFormatting = false,
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = is_using_eslint,
    },
    on_init = custom_on_init,
    root_dir = vim.loop.cwd,
  },
  tailwindcssls = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
   on_new_config = function(new_config)
          if not new_config.settings then new_config.settings = {} end
          if not new_config.settings.editor then new_config.settings.editor = {} end
          if not new_config.settings.editor.tabSize then
            -- set tab size for hover
            new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
          end
        end,
    root_dir = vim.loop.cwd,
    settings = {
      tailwindCSS = {
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning"
        },
        validate = true
      }
    }
  },

  emmetls = {
    cmd = {'emmet-ls', '--stdio'};
    filetypes = {'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'};
    root_dir = vim.loop.cwd
  },

  -- denols = {
  --   filetypes = { "javascript", "typescript", "typescriptreact" },
  --   root_dir = vim.loop.cwd,
  --   settings = {
  --     documentFormatting = false
  --   }
  -- },
  html = {},
  cssls = {},
  intelephense = {},
  rust_analyzer = {},
  clangd = {},
  gopls = {
    root_dir = vim.loop.cwd,
  },

  efm = {
    cmd = { "efm-langserver" },
    on_attach = function(client)
      vim.cmd 'augroup lsp_buf_format'
      vim.cmd 'au!'
      vim.cmd 'autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()'
      vim.cmd 'augroup END'
      -- vim.cmd [[:lua vim.lsp.buf.formatting_sync()]]
      client.resolved_capabilities.rename = false
      client.resolved_capabilities.hover = false
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.completion = false
    end,
    on_init = custom_on_init,
    filetypes = { "javascript", "typescript", "typescriptreact", "svelte" },
    settings = {
      rootMarkers = { ".git", "package.json" },
      languages = {
        javascript = { eslint, prettier },
        typescript = { eslint, prettier },
        typescriptreact = { eslint, prettier },
        svelte = { eslint },
      },
    },
  },
  svelte = {
    on_attach = function(client)
      mappings.lsp_mappings()

      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      client.server_capabilities.completionProvider.triggerCharacters = {
        ".",
        "\"",
        "'",
        "`",
        "/",
        "@",
        "*",
        "#",
        "$",
        "+",
        "^",
        "(",
        "[",
        "-",
        ":",
      }
    end,
    handlers = {
      ["textDocument/publishDiagnostics"] = is_using_eslint,
    },
    on_init = custom_on_init,
    filetypes = { "svelte" },
    settings = {
      svelte = {
        plugin = {
          html = {
            completions = {
              enable = true,
              emmet = true,
            },
          },
          svelte = {
            completions = {
              enable = true,
              emmet = false,
            },
            compilerWarnings = {
              ["a11y-invalid-attribute"] = "ignore",
            },
          },
          css = {
            completions = {
              enable = true,
              emmet = false,
            },
          },
        },
      },
    },
  },
  sumneko_lua = {
    cmd = {
      sumneko_root .. "/bin/Linux/lua-language-server",
      "-E",
      sumneko_root .. "/main.lua",
    },
    on_attach = custom_on_attach,
    on_init = custom_on_init,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
        diagnostics = {
          enable = true,
          globals = {
            "vim",
            "describe",
            "it",
            "before_each",
            "after_each",
            "awesome",
            "theme",
            "client",
            "P",
          },
        },
        workspace = {
          preloadFileSize = 400,
        },
      },
    },
  },
}

for name, opts in ipairs(servers) do
  local client = nvim_lsp[name]
  client.setup({
    cmd = opts.cmd or client.cmd,
    filetypes = opts.filetypes or client.filetypes,
    on_attach = opts.on_attach or require'completion'.custom_on_attach,
    on_init = opts.on_init or custom_on_init,
    handlers = opts.handlers or client.handlers,
    root_dir = opts.root_dir or client.root_dir,
    capabilities = opts.capabilities or custom_capabilities(),
    settings = opts.settings or {},
  })
end

-- jdtls stuff
vim.api.nvim_exec(
  [[
  augroup jdtls
  au!
  au FileType java lua require'jdtls'.start_or_attach({cmd = {'/home/elianiva/.scripts/run_jdtls'}, on_attach = require'modules.lsp._mappings'.lsp_mappings("jdtls")})
  augroup END
]],
  false
)



local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'};
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
lspconfig.emmet_ls.setup{ capabilities = capabilities; }

local capba = vim.lsp.protocol.make_client_capabilities()
capba.textDocument.completion.completionItem.snippetSupport = true

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in ipairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
