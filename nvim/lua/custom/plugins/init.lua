-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Show current line highlight
vim.o.cursorline = true

-- Show always a block
vim.o.guicursor = 'n-v-c-i:block'

-- Make line numbers relative
vim.wo.relativenumber = true

-- Make scroll off
vim.o.scrolloff = 8

-- Configuration for indent-blankline
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

vim.o.smarttab = true

-- TODO: Add this for treesitter
-- autotag = {
--   enabled = true
-- }

return {
}
