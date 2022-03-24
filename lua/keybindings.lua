require('formatter').setup({
  logging = false,
  filtype = {
    javascript = {
      function()
        return {
          exe = "prettierd",
          args = {vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },
  }
})

vim.g.mapleader = " "

local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end


-- disabling arrow keys
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')


-- contorl + s to save
key_mapper('n', '<C-s>', ':w!<CR>')

-- better navigation between splits
key_mapper('n', '<C-h>', '<C-w>h')
key_mapper('n', '<C-l>', '<C-w>l')
key_mapper('n', '<C-j>', '<C-w>j')
key_mapper('n', '<C-k>', '<C-w>k')

-- Git 
key_mapper('n', '<leader>gs', ':G<CR>')
key_mapper('n', '<leader>gc', ':Git commit<CR>')

-- lsp
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')


-- Telescope
key_mapper('n', '<leader>ff', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- file explorer nvim-tree
key_mapper('n', '<leader>e', ':NvimTreeToggle<CR>')

-- barbar
-- change between tabs
key_mapper('n', '<Tab>', ':bnext<CR>')
key_mapper('n', '<S-Tab>', ':bprevious<CR>')
key_mapper('n', '<leader>bb', ':BufferCloseAllButCurrent<CR>')


-- commenting
-- key_mapper('n', '<c-/>', '<Plug>Commentary<CR>')
