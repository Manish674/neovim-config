local remap = vim.api.nvim_set_keymap

vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"

require("compe").setup({
  enabled              = true,
  debug                = false,
  min_length           = 2,
  preselect            = "disable",
  source_timeout       = 200,
  incomplete_delay     = 400,
  allow_prefix_unmatch = false,

  source = {
    path     = true,
    calc     = true,
    buffer   = true,
    vsnip    = true,
    nvim_lsp = true,
    nvim_lua = true,
  },
})

Util.trigger_completion = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"]()
    end
  end

  local curr_col = vim.fn.col(".")
  local prev_char = vim.fn.getline("."):sub(curr_col - 1, curr_col - 1)

  -- minimal autopairs-like behaviour
  if prev_char == "{" then return Util.t("<CR>}<C-o>O") end
  if prev_char == "[" then return Util.t("<CR>]<C-o>O") end
  if prev_char == "(" then return Util.t("<CR>)<C-o>O") end
  if prev_char == ">" then return Util.t("<CR><C-o>O") end -- html indents
  return Util.t("<CR>")
end

remap(
  "i",
  "<CR>",
  "v:lua.Util.trigger_completion()",
  { expr = true, silent = true }
)
remap(
  "i",
  "<Tab>",
  table.concat({
    "pumvisible() ? \"<C-n>\" : v:lua.Util.check_backspace()",
    "? \"<Tab>\" : compe#confirm()",
  }),
  { silent = true, noremap = true, expr = true }
)

remap(
  "i",
  "<S-Tab>",
  "pumvisible() ? \"<C-p>\" : \"<S-Tab>\"",
  { noremap = true, expr = true }
)
remap(
  "i",
  "<C-Space>",
  "compe#complete()",
  { noremap = true, expr = true, silent = true }
)
