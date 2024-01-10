-- Configure and load colorscheme
require("kanagawa").setup(
    {
        compile = true,
        colors = {
            theme = {
                all = {
                    ui = {bg_gutter = "none"}
                }
            }
        }
    }
)
vim.cmd("colorscheme kanagawa-dragon")

-- Filetree config
require("nvim-tree").setup(
    {
        sort = {sorter = "case_sensitive"},
        view = {width = 25},
        renderer = {group_empty = true},
        filters = {dotfiles = true}
    }
)

-- Lualine config
require("lualine").setup(
    {
        options = {
            component_separators = {left = "", right = ""},
            section_separators = {left = "", right = ""}
        }
    }
)

-- Indent blankline
require("ibl").setup({})

--Comments
require("Comment").setup({})

-- Treesiter config
vim.defer_fn(
    function()
        require "nvim-treesitter.configs".setup {
            ensure_installed = {"c", "lua", "python", "go"},
            sync_install = false,
            auto_install = false,
            ignore_install = {},
            highlight = {enable = true}
        }
    end,
    0
)

-- Git workflow
require("gitsigns").setup({})

--Copilot
require("copilot").setup(
    {
        panel = {
            auto_refresh = false,
            keymap = {
                accept = "<CR>",
                jump_prev = "[[",
                jump_next = "]]",
                refresh = "gr",
                open = "<M-CR>"
            }
        },
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = "<M-l>",
                prev = "<M-[>",
                next = "<M-]>",
                dismiss = "<C-]>"
            }
        }
    }
)

-- LSP
require("mason").setup({})
require("mason-lspconfig").setup({})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
    gopls = {},
    pyright = {},
    rust_analyzer = {}
}

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers)
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes
        }
    end
}

-- Completions
local cmp = require "cmp"
local luasnip = require "luasnip"
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    completion = {
        completeopt = "menu,menuone,noinsert"
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            {"i", "s"}
        ),
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            {"i", "s"}
        )
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "path"}
    }
}

