-- local lspconfig = require("lspconfig")
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

local buf_map = function(bufnr, mode, lhs, rhs, opts) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>z', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async=true })<CR>", opts)


  -- formatting
  if client.name == 'tsserver' then
    print("tsserver")
    client.server_capabilities.document_formatting = true
  end

  --protocol.SymbolKind = { }
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx" },
  capabilities = capabilities
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  filetypes = { "css", "scss" },
  capabilities = capabilities
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact","javascript", "javascriptreact", "typescript.tsx" },
  capabilities = capabilities
}

nvim_lsp.prismals.setup {
  on_attach = on_attach,
  -- filetypes = { "sql" },
  capabilities = capabilities
}

nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  -- filetypes = { "sql" },
  capabilities = capabilities
}

nvim_lsp.sqlls.setup {
  on_attach = on_attach,
  -- filetypes = { "sql" },
  capabilities = capabilities
}

--~/.local/share/nvim/lsp_servers/rust 
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }}
