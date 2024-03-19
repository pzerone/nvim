-- Set leader key before anything
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw so that we can use Nvimtree without hassle
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Plugins and their dependencies
-- Configs for these plugins are done seperately
require("lazy").setup(
    {
        --Colorscheme
        {"rebelot/kanagawa.nvim", lazy = false, priority = 1000},
        -- Comment with ease
        {"numToStr/Comment.nvim"},
        -- Better autopairs
        {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}},
        -- Diagnostics view
        {"folke/trouble.nvim", opts = {}},
        -- Git workflows
        {"tpope/vim-fugitive"},
        {"lewis6991/gitsigns.nvim"},
        -- File tree
        {"nvim-tree/nvim-tree.lua"},
        -- Statusbar
        {
            "nvim-lualine/lualine.nvim",
            -- Icon support
            dependencies = {"nvim-tree/nvim-web-devicons"}
        },
        -- Find files - fzf
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.5",
            dependencies = {
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}
            }
        },
        -- Indent lines
        {"lukas-reineke/indent-blankline.nvim", main = "ibl"},
        --Treesitter
        {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
        -- LSP servers and manager
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                {"williamboman/mason.nvim", config = true},
                {"williamboman/mason-lspconfig.nvim"}
            }
        },
        -- Autocompletion
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                {"L3MON4D3/LuaSnip"},
                {"saadparwaiz1/cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-path"},
                {"rafamadriz/friendly-snippets"}
            }
        },
        -- Formatting
        {
            "stevearc/conform.nvim",
            event = {"BufWritePre"},
            cmd = {"ConformInfo"},
            opts = {},
            keys = {
                {
                    "<leader>fm",
                    function()
                        require("conform").format({async = true, lsp_fallback = true})
                    end,
                    mode = "",
                    desc = "Format buffer"
                }
            },
            opts = {
                formatters_by_ft = {
                    lua = {"stylua"},
                    python = {"isort", "black"},
                    javascript = {{"prettierd", "prettier"}}
                },
                format_on_save = {timeout_ms = 500, lsp_fallback = true}
            }
        }
    }
) -- Lazy config ends

