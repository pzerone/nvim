return {
    {"rebelot/kanagawa.nvim", lazy = false, priority = 1000},
    {"numToStr/Comment.nvim"},
    {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}},
    {"folke/trouble.nvim", opts = {}},
    {"tpope/vim-fugitive"},
    {"lewis6991/gitsigns.nvim"},
    {"nvim-tree/nvim-tree.lua"},
    {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}},
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {{"nvim-lua/plenary.nvim"}, {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}}
    },
    {"lukas-reineke/indent-blankline.nvim", main = "ibl"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}
