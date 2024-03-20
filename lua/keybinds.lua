vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", {silent = true})
local a = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", a.find_files, {})
vim.keymap.set("n", "<leader>fg", a.live_grep, {})
vim.keymap.set("n", "<leader><space>", a.buffers, {})
vim.keymap.set("n", "<leader>fh", a.help_tags, {})
vim.keymap.set(
    "n",
    "<leader>/",
    function()
        require("telescope.builtin").current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({winblend = 10, previewer = false})
        )
    end
)
vim.keymap.set("n", "gd", a.lsp_definitions, {})
vim.keymap.set("n", "gr", a.lsp_references, {})
vim.keymap.set("n", "gI", a.lsp_implementations, {})
vim.keymap.set("n", "<leader>fs", a.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set(
    "n",
    "<leader>xx",
    function()
        require("trouble").toggle()
    end
)
vim.keymap.set(
    "n",
    "<leader>xw",
    function()
        require("trouble").toggle("workspace_diagnostics")
    end
)
vim.keymap.set(
    "n",
    "<leader>xd",
    function()
        require("trouble").toggle("document_diagnostics")
    end
)
vim.keymap.set(
    "n",
    "<leader>xq",
    function()
        require("trouble").toggle("quickfix")
    end
)
vim.keymap.set(
    "n",
    "<leader>xl",
    function()
        require("trouble").toggle("loclist")
    end
)
vim.keymap.set(
    "n",
    "gR",
    function()
        require("trouble").toggle("lsp_references")
    end
)
vim.keymap.set("n", "<leader>E", ":NvimTreeFocus<CR>", {silent = true})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {silent = true})
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>p", '"+p', {})
vim.keymap.set("n", "<leader>p", '"+p', {})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
