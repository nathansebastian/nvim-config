-- local cmp = require('cmp')
-- local dap = require ('dap')
-- telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- tree
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFileToggle<cr>")

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

-- undo-tree
vim.g.undotree_DiffCommand = "FC"
vim.keymap.set("n" ,"<C-u>", ":UndotreeToggle<cr>")

--LSP
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})
-- debugger

-- vim.keymap.set("n" ,"<F5>", dap.continue, {desc = 'Debug: Start'})
-- vim.keymap.set("n" ,"<F12>", dap.continue, {desc = 'Debug: Continue'})
-- vim.keymap.set("n" ,"<F11>", dap.step_into, {desc = 'Debug: Step Into'})
-- vim.keymap.set("n" ,"<F10>", dap.step_over, {desc = 'Debug: Step Over'})
-- vim.keymap.set("n" ,"<F8>", dap.terminate, {desc = 'Debug: Terminate'})
-- vim.keymap.set("n" ,"<leader>b", dap.toggle_breakpoint, {desc = 'Debug: Toggle Breakpoint'})
-- vim.keymap.set("n" ,"<leader>B", dap.toggle_breakpoint, function()
--    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
-- end, {desc =  'Debug: Set Breakpoint'})

-- fugitive/gitstatus
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- LSP Classic completion keymaps
-- vim.keymap.set("n" ,"<CR>",  cmp.mapping.confirm { select = true })
-- vim.keymap.set("n" ,"<Tab>",  cmp.mapping.select_next_item())
-- vim.keymap.set("n" ,"<S-Tab>",  cmp.mapping.select_prev_item())

