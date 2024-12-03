vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pe",vim.cmd.Ex)

vim.keymap.set({"n","v"},";","<right>")
vim.keymap.set({"n","v"},"l","<left>")
vim.keymap.set({"n","v"},"h","<Nop>")
vim.keymap.set("i", "<RightMouse>", '<C-o>:normal "+gp<CR>', { desc = "Use right mouse to paste clipboard + in insert mode"})

vim.keymap.set("n", "<leader>q",":q!<cr>")

-- buffers
vim.keymap.set("n", "<C-x>", ":bd<cr>")
vim.keymap.set("n", "<C-n>", ":bn<cr>")

-- yank to clipboard
vim.keymap.set({"n", "v"}, "y", [["+y]])

vim.keymap.set({"n"}, "<leader>na", ":set number norelativenumber<cr>")
vim.keymap.set({"n"}, "<leader>nr", ":set number relativenumber<cr>")
