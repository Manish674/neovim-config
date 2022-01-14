
require('material').setup({
	contrast = {
			sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
			floating_windows = true, -- Enable contrast for floating windows
			line_numbers = true, -- Enable contrast background for line numbers
			sign_column = false, -- Enable contrast background for the sign column
			cursor_line = true, -- Enable darker background for the cursor line
			non_current_windows = false, -- Enable darker background for non-current windows
			popup_menu = false, -- Enable lighter background for the popup menu
	},
  italics = {
			comments = true, -- Enable italic comments
			keywords = true, -- Enable italic keywords
			functions = true, -- Enable italic functions
			strings = true, -- Enable italic strings
			variables = true -- Enable italic variables
		},
  })

vim.g.material_style = "darker"
vim.cmd[[colo material]]
