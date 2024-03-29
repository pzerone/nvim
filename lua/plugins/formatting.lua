return {
    "stevearc/conform.nvim",
    event = {"BufWritePre"},
    cmd = {"ConformInfo"},
    keys = {{"<leader>fm", function()
                require("conform").format({async = true, lsp_fallback = true})
            end, mode = "", desc = "Format buffer"}},
    opts = {
        formatters_by_ft = {lua = {"stylua"}, python = {"black"}},
        format_on_save = {timeout_ms = 500, lsp_fallback = true},
        formatters = {}
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
