local vim = vim
local execute = vim.api.nvim_command

local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'

local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- add you plugins here like: use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'

  -- colorschemes
  use 'folke/tokyonight.nvim'
  -- these are optional themes but I hear good things about gloombuddy ;)
  -- colorbuddy allows us to run the gloombuddy theme
  use 'sainnhe/edge'
  use 'arcticicestudio/nord-vim'
  use 'sainnhe/gruvbox-material'
  use 'gruvbox-community/gruvbox'
  use 'bkegley/gloombuddy'

  -- use 'https://github.com/lukas-reineke/format.nvim.git'

  -- sneaking some formatting in here too
  -- use {'prettier/vim-prettier', run = 'npm install' }
  use 'sbdchd/neoformat'

  --- astronauta to use nnoremap inoremap
  use 'tjdevries/astronauta.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim';
  use { "mfussenegger/nvim-jdtls", opt = false } -- jdtls
  use { "tami5/sql.nvim", opt = false } -- sql bindings in LuaJIT
  use'kabouzeid/nvim-lspinstall'

  use "jose-elias-alvarez/null-ls.nvim" 
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- autocomplete
  use 'hrsh7th/vim-vsnip'

  -- fuzzy finder telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'


  -- ranger
  use 'kevinhwang91/rnvimr'

  -- file explorer
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
  }


  -- use 'alvan/vim-closetag'

  -- galaxyline
  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function() require'plugins/galaxyline' end,
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- auto pair
  use 'windwp/nvim-autopairs'

  -- auto closing and renaming tag
  use 'windwp/nvim-ts-autotag'

  -- colorizer
  use 'norcalli/nvim-colorizer.lua'

  -- file bar ?
  use 'romgrk/barbar.nvim'

  use {'lourenci/github-colors', branch = 'main'}

  use 'mhartington/formatter.nvim'

  use({
    'NTBBloodbath/doom-one.nvim',
    config = function()
        require('doom-one').setup({
            cursor_coloring = false,
            terminal_colors = false,
            italic_comments = false,
            enable_treesitter = true,
            transparent_background = true,
            pumblend = {
                enable = true,
                transparency_amount = 20,
            },
            plugins_integrations = {
                neorg = true,
                barbar = true,
                bufferline = false,
                gitgutter = false,
                gitsigns = true,
                telescope = false,
                neogit = true,
                nvim_tree = true,
                dashboard = true,
                startify = true,
                whichkey = true,
                indent_blankline = true,
                vim_illuminate = true,
                lspsaga = false,
            },
        })
    end,
  })

  --vim-commentary
  use 'tpope/vim-commentary'
  -- use 'https://github.com/Shougo/context_filetype.vim.git'
  -- use 'tyru/caw.vim'
  end
)

