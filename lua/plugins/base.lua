return {
--Colorscheme
{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
-- Comment with ease
{ "numToStr/Comment.nvim" },
-- Better autopairs
{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
-- Diagnostics view
{ "folke/trouble.nvim", opts = {} },
-- Git workflows
{ "tpope/vim-fugitive" },
{ "lewis6991/gitsigns.nvim" },
-- File tree
{ "nvim-tree/nvim-tree.lua" },
-- Statusbar
{
	"nvim-lualine/lualine.nvim",
	-- Icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
},
-- Find files - fzf
{
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
},
-- Indent lines
{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },
--Treesitter
{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}
