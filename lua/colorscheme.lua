vim.g.material_style = "darker"

-- require("github-theme").setup({
--   theme_style = "dimmed",
--   -- other config
-- })

-- require('material').setup({
-- 	contrast = {
-- 			sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
-- 			floating_windows = true, -- Enable contrast for floating windows
-- 			line_numbers = true, -- Enable contrast background for line numbers
-- 			sign_column = false, -- Enable contrast background for the sign column
-- 			cursor_line = true, -- Enable darker background for the cursor line
-- 			non_current_windows = false, -- Enable darker background for non-current windows
-- 			popup_menu = false, -- Enable lighter background for the popup menu
-- 	},
--   italics = {
-- 			comments = true, -- Enable italic comments
-- 			keywords = true, -- Enable italic keywords
-- 			functions = true, -- Enable italic functions
-- 			strings = true, -- Enable italic strings
-- 			variables = true -- Enable italic variables
-- 		},
--   })
-- vim.cmd[[colo material]]

-- tokyonight
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_transparent = true
-- tokyonight_italic_keywords = true
-- tokyonight_italic_comments = true
-- tokyonight_dark_sidebar = true
-- tokyonight_lualine_bold = true
-- vim.g.tokyonight_sidebars = { "NvimTree" "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

vim.cmd[[colo gruvbox]]

-- -- gray
-- vim.cmd[[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
-- -- blue
-- vim.cmd[[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
-- vim.cmd[[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
-- -- light blue
-- vim.cmd[[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
-- vim.cmd[[highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE]]
-- vim.cmd[[highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE]]
-- -- pink
-- vim.cmd[[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
-- vim.cmd[[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]]
-- -- front
-- vim.cmd[[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
-- vim.cmd[[highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4]]
-- vim.cmd[[highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]]


-- for tranparency 
-- vim.cmd[[au ColorScheme * hi Normal ctermbg=none guibg=none]]
-- vim.cmd[[au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red]]

-- vim.g.gruvbox_contrast_dark = hard




