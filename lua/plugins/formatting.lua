return {
    "stevearc/conform.nvim",
    event = {"BufWritePre"},
    cmd = {"ConformInfo"},
    keys = {{"<leader>fm", function()
                require("conform").format({async = true, lsp_fallback = true})
            end, mode = "", desc = "Format buffer"}},
    opts = {
        formatters_by_ft = { python = {"black"}},
        format_on_save = false,
        formatters = {}
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
