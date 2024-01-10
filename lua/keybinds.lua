vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", {silent = true})

-- Telescope keybinds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- LSP keymaps
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gI', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

-- Trouble diagnostics
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- Nvimtree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>N", ":NvimTreeFocus<CR>", {silent = true})

-- Yank and paste from system clipboard
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>p", '"+p', {})
vim.keymap.set("n", "<leader>p", '"+p', {})


-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

