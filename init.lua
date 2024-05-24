-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

-- Sane configs
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.guicursor = "i:block"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 15

vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.completeopt = "menu", "menuone", "noselect"
vim.wo.signcolumn = "yes"

-- Disable netrw for nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Custom icons for lsp diagnostics
vim.diagnostic.config(
    {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = ""
            }
        }
    }
)

-- Sane keybinds
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>p", '"+p', {})
vim.keymap.set("n", "<leader>p", '"+p', {})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

-- Force use hjkl
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Plugin configurations
require("lazy").setup(
    {
        {
            -- Load the bling✨ first
            "rebelot/kanagawa.nvim",
            priority = 1000,
            lazy = false,
            opts = {
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
            },
            init = function()
                vim.cmd("colorscheme kanagawa-dragon")
            end
        },
        {
            -- Status line
            "nvim-lualine/lualine.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            opts = {
                options = {component_separators = {left = "", right = ""}, section_separators = {left = "", right = ""}}
            }
        },
        {
            -- File tree
            "nvim-tree/nvim-tree.lua",
            opts = {
                sort = {sorter = "case_sensitive"},
                view = {width = 30},
                renderer = {group_empty = true},
                filters = {dotfiles = false}
            },
            keys = {
                {"<leader>E", ":NvimTreeFocus<CR>", desc = "Focus nvim tree", silent = true},
                {"<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle nvim tree", silent = true}
            }
        },
        {
            -- Blank line indentation
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {
                indent = {char = "│", tab_char = "│"},
                whitespace = {remove_blankline_trail = false},
                scope = {enabled = false}
            }
        },
        -- Stuff that does not require any configs
        {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}, -- Automatic bracket pairing
        {"lewis6991/gitsigns.nvim", opts = {}}, -- Git signs
        {"numToStr/Comment.nvim", opts = {}}, -- To toggle linewise/blockwise comments
        {
            -- Shows diagnostics info on a seperate window
            "folke/trouble.nvim",
            opts = {},
            keys = {
                {"<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle trouble"},
                {"<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics"},
                {"<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics"},
                {"<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix"},
                {"<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loclist"}
            }
        },
        {
            -- Better syntax highlighting
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local configs = require("nvim-treesitter.configs")
                configs.setup(
                    {
                        ensure_installed = {"c", "lua", "go", "python"},
                        sync_install = false,
                        highlight = {enable = true},
                        indent = {enable = true}
                    }
                )
            end
        },
        {
            -- Floating menu based find file/lsp stuff
            "nvim-telescope/telescope.nvim",
            tag = "0.1.6",
            dependencies = {
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}
            },
            keys = {
                {"<leader><space>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer"},
                {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files in current directory"},
                {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep"},
                {"<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help"}
            }
        },
        {
            -- Autocompletion and helpers
            "hrsh7th/nvim-cmp",
            dependencies = {
                {"L3MON4D3/LuaSnip"},
                {"saadparwaiz1/cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-path"},
                {"rafamadriz/friendly-snippets"}
            },
            event = "InsertEnter",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                local cmp = require("cmp")
                local luasnip = require("luasnip")
                local select_opts = {behavior = cmp.SelectBehavior.Select}
                cmp.setup(
                    {
                        snippet = {
                            expand = function(args)
                                require("luasnip").lsp_expand(args.body)
                            end
                        },
                        mapping = {
                            ["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
                            ["<C-j>"] = cmp.mapping.select_next_item(select_opts),
                            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                            ["<C-d>"] = cmp.mapping.scroll_docs(4),
                            ["<C-e>"] = cmp.mapping.abort(),
                            ["<C-y>"] = cmp.mapping.confirm({select = true}),
                            ["<CR>"] = cmp.mapping.confirm({select = false}),
                            ["<C-f>"] = cmp.mapping(
                                function(fallback)
                                    if luasnip.jumpable(1) then
                                        luasnip.jump(1)
                                    else
                                        fallback()
                                    end
                                end,
                                {"i", "s"}
                            ),
                            ["<C-b>"] = cmp.mapping(
                                function(fallback)
                                    if luasnip.jumpable(-1) then
                                        luasnip.jump(-1)
                                    else
                                        fallback()
                                    end
                                end,
                                {"i", "s"}
                            ),
                            ["<Tab>"] = cmp.mapping(
                                function(fallback)
                                    local col = vim.fn.col(".") - 1

                                    if cmp.visible() then
                                        cmp.select_next_item(select_opts)
                                    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                                        fallback()
                                    else
                                        cmp.complete()
                                    end
                                end,
                                {"i", "s"}
                            ),
                            ["<S-Tab>"] = cmp.mapping(
                                function(fallback)
                                    if cmp.visible() then
                                        cmp.select_prev_item(select_opts)
                                    else
                                        fallback()
                                    end
                                end,
                                {"i", "s"}
                            )
                        },
                        sources = cmp.config.sources(
                            {
                                {name = "nvim_lsp"},
                                {name = "buffer"},
                                {name = "path"},
                                {name = "luasnip"}
                            },
                            {
                                {name = "buffer"}
                            }
                        ),
                        window = {
                            documentation = cmp.config.window.bordered()
                        }
                    }
                )
            end
        },
        -- LSP setup
        {"neovim/nvim-lspconfig"},
        {"williamboman/mason.nvim", opts = {}},
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                -- Add any servers here for it to be preinstalled
                ensure_installed = {
                    "gopls",
                    "basedpyright"
                },
                handlers = {
                    -- Default setup for all LSP servers
                    function(server_name)
                        vim.api.nvim_create_autocmd(
                            "LspAttach",
                            {
                                desc = "LSP actions",
                                callback = function(event)
                                    -- Keybinds available only when a handler is attached
                                    local opts = {buffer = event.buf}
                                    -- Trigger code completion
                                    vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)
                                    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
                                    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
                                    vim.keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<cr>", opts)
                                    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
                                    vim.keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", opts)
                                    -- vim.keymap.set("n", "gl", "<cmd>Telescope diagnostics<cr>") -- Trouble does the same

                                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                                    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

                                    -- Inlay hints for supported handlers
                                    local id = vim.tbl_get(event, "data", "client_id")
                                    local client = id and vim.lsp.get_client_by_id(id)
                                    if client == nil or not client.supports_method("textDocument/inlayHint") then
                                        return
                                    end
                                    vim.lsp.inlay_hint.enable(true, {bufnr = event.buf})
                                end
                            }
                        )
                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        capabilities =
                            vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,
                    ["basedpyright"] = function()
                        -- Overrides for specific ones
                        require("lspconfig").basedpyright.setup {
                            settings = {
                                basedpyright = {
                                    analysis = {typeCheckingMode = "standard"}
                                }
                            }
                        }
                    end
                }
            }
        },
        {
            -- Better formatting
            "stevearc/conform.nvim",
            event = {"BufWritePre"},
            cmd = {"ConformInfo"},
            keys = {
                {
                    "<F3>",
                    function()
                        require("conform").format({async = true, lsp_fallback = true})
                    end,
                    mode = "",
                    desc = "Format buffer"
                }
            },
            opts = {
                formatters_by_ft = {python = {"ruff_format"}},
                format_on_save = false,
                formatters = {}
            },
            init = function()
                vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            end
        }
    }
)
-- Config ends

