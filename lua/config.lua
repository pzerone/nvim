require("kanagawa").setup(
    {
        compile = true,
        colors = {theme = {all = {ui = {bg_gutter = "none"}}}},
        transparent = true,
        overrides = function(a)
            local b = a.theme
            return {
                Pmenu = {fg = b.ui.shade0, bg = b.ui.bg_p1},
                PmenuSel = {fg = "NONE", bg = b.ui.bg_p2},
                PmenuSbar = {bg = b.ui.bg_m1},
                PmenuThumb = {bg = b.ui.bg_p2}
            }
        end
    }
)
vim.cmd("colorscheme kanagawa-dragon")
require("nvim-tree").setup(
    {
        sort = {sorter = "case_sensitive"},
        view = {width = 30},
        renderer = {group_empty = true},
        filters = {dotfiles = false}
    }
)
require("lualine").setup(
    {options = {component_separators = {left = "", right = ""}, section_separators = {left = "", right = ""}}}
)

require("ibl").setup {
    indent = { char = "│", tab_char = "│", },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}

require("Comment").setup({})
vim.defer_fn(
    function()
        require("nvim-treesitter.configs").setup(
            {
                ensure_installed = {"c", "lua", "python", "go", "bash"},
                sync_install = false,
                auto_install = false,
                ignore_install = {},
                highlight = {enable = true}
            }
        )
    end,
    0
)
require("gitsigns").setup({})
require("mason").setup({})
require("mason-lspconfig").setup({})
local c = vim.lsp.protocol.make_client_capabilities()
c = require("cmp_nvim_lsp").default_capabilities(c)
vim.diagnostic.config({virtual_text = {prefix = ""}, signs = true})
local d = {gopls = {}}
local e = require("mason-lspconfig")
e.setup({ensure_installed = vim.tbl_keys(d)})
e.setup_handlers(
    {
        function(f)
            require("lspconfig")[f].setup(
                {capabilities = c, on_attach = on_attach, settings = d[f], filetypes = (d[f] or {}).filetypes}
            )
        end
    }
)
local g = require("cmp")
local h = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
h.config.setup({})
g.setup(
    {
        snippet = {expand = function(i)
                h.lsp_expand(i.body)
            end},
        completion = {completeopt = "menu,menuone,noinsert"},
        mapping = g.mapping.preset.insert(
            {
                ["<C-n>"] = g.mapping.select_next_item(),
                ["<C-p>"] = g.mapping.select_prev_item(),
                ["<C-b>"] = g.mapping.scroll_docs(-4),
                ["<C-f>"] = g.mapping.scroll_docs(4),
                ["<C-Space>"] = g.mapping.complete({}),
                ["<CR>"] = g.mapping.confirm({behavior = g.ConfirmBehavior.Replace, select = true}),
                ["<Tab>"] = g.mapping(
                    function(j)
                        if g.visible() then
                            g.select_next_item()
                        elseif h.expand_or_locally_jumpable() then
                            h.expand_or_jump()
                        else
                            j()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-Tab>"] = g.mapping(
                    function(j)
                        if g.visible() then
                            g.select_prev_item()
                        elseif h.locally_jumpable(-1) then
                            h.jump(-1)
                        else
                            j()
                        end
                    end,
                    {"i", "s"}
                )
            }
        ),
        sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"}}
    }
)
