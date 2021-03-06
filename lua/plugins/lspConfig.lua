local lspconfig = require("lspconfig")
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
  buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)


  -- formatting
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
    '???', -- Text
    '???', -- Method
    '???', -- Function
    '???', -- Constructor
    '???', -- Field
    '???', -- Variable
    '???', -- Class
    '???', -- Interface
    '???', -- Module
    '???', -- Property
    '???', -- Unit
    '???', -- Value
    '???', -- Enum
    '???', -- Keyword
    '???', -- Snippet
    '???', -- Color
    '???', -- File
    '???', -- Reference
    '???', -- Folder
    '???', -- EnumMember
    '???', -- Constant
    '???', -- Struct
    '???', -- Event
    '???', -- Operator
    '???', -- TypeParameter
  }
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx" },
  capabilities = capabilities
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  filetypes = { "css" },
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

nvim_lsp.sqlls.setup {
  on_attach = on_attach,
  -- filetypes = { "sql" },
  capabilities = capabilities
}

--~/.local/share/nvim/lsp_servers/rust 
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  filetypes = {"rust"},
  capabilities = capabilities
}

-- nvim_lsp.diagnosticls.setup {
--   on_attach = on_attach,
--   filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
--   init_options = {
--     linters = {
--       eslint = {
--         command = 'eslint_d',
--         rootPatterns = { '.git' },
--         debounce = 100,
--         args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
--         sourceName = 'eslint_d',
--         parseJson = {
--           errorsRoot = '[0].messages',
--           line = 'line',
--           column = 'column',
--           endLine = 'endLine',
--           endColumn = 'endColumn',
--           message = '[eslint] ${message} [${ruleId}]',
--           security = 'severity'
--         },
--         securities = {
--           [2] = 'error',
--           [1] = 'warning'
--         }
--       },
--     },
--     filetypes = {
--       javascript = 'eslint',
--       javascriptreact = 'eslint',
--       typescript = 'eslint',
--       typescriptreact = 'eslint',
--     },
--     formatters = {
--       eslint_d = {
--         command = 'eslint_d',
--         rootPatterns = { '.git' },
--         args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
--         rootPatterns = { '.git' },
--       },
--       -- prettier = {
--       --   command = 'prettier_d_slim',
--       --   rootPatterns = { '.git' },
--       --   -- requiredFiles: { 'prettier.config.js' },
--       --   args = { '--stdin', '--stdin-filepath', '%filename' }
--       -- }
--     },
--     formatFiletypes = {
--       -- css = 'prettier',
--       -- javascript = 'prettier',
--       -- javascriptreact = 'prettier',
--       -- json = 'prettier',
--       -- scss = 'prettier',
--       -- less = 'prettier',
--       -- typescript = 'prettier',
--       -- typescriptreact = 'prettier',
--       -- json = 'prettier',
--       -- markdown = 'prettier',
--     }
--   }
-- }


-- lspconfig.tsserver.setup({
--     on_attach = on_attach
-- })

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require'lspconfig'.cssls.setup {
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--         client.resolved_capabilities.document_range_formatting = false        
--         local ts_utils = require("nvim-lsp-ts-utils")
--         ts_utils.setup({
--             eslint_bin = "eslint_d",
--             eslint_enable_diagnostics = true,
--             eslint_enable_code_actions = true,
--             enable_formatting = true,
--             formatter = "prettierd",
--         })
--         ts_utils.setup_client(client)        
--         buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
--         buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
--         buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")        
--         on_attach(client, bufnr)
--     end,
--   capabilities = capabilities,
-- }

-- require'lspconfig'.tailwindcss.setup{
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--         client.resolved_capabilities.document_range_formatting = false        
--         local ts_utils = require("nvim-lsp-ts-utils")
--         ts_utils.setup({
--             eslint_bin = "eslint_d",
--             eslint_enable_diagnostics = true,
--             eslint_enable_code_actions = true,
--             enable_formatting = true,
--             formatter = "prettierd",
--         })
--         ts_utils.setup_client(client)        
--         buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
--         buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
--         buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")        
--         on_attach(client, bufnr)
--     end,
--    capabilities = capabilities,
-- }

-- require'lspconfig'.jedi_language_server.setup{
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--         client.resolved_capabilities.document_range_formatting = false        
--         local ts_utils = require("nvim-lsp-ts-utils")
--         ts_utils.setup({
--             eslint_bin = "eslint_d",
--             eslint_enable_diagnostics = true,
--             eslint_enable_code_actions = true,
--             enable_formatting = true,
--             formatter = "prettierd",
--         })
--         ts_utils.setup_client(client)        
--         buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
--         buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
--         buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")        
--         on_attach(client, bufnr)
--     end,
--    capabilities = capabilities,
-- }

-- require'lspconfig'.html.setup{
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--         client.resolved_capabilities.document_range_formatting = false        
--         local ts_utils = require("nvim-lsp-ts-utils")
--         ts_utils.setup({
--             eslint_bin = "eslint_d",
--             eslint_enable_diagnostics = true,
--             eslint_enable_code_actions = true,
--             enable_formatting = true,
--             formatter = "prettierd",
--         })
--         ts_utils.setup_client(client)        
--         buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
--         buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
--         buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")        
--         on_attach(client, bufnr)
--     end,
--    capabilities = capabilities,
-- }
