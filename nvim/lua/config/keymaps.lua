local Util = require("lazyvim.util")

-- floating terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
vim.keymap.set("n", "<leader>tt", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>tT", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })

vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>r", "<cmd>AerialToggle!<CR>")
