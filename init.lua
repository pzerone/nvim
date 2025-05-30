-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Sane configs
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.breakindent = true
vim.opt.completeopt = "menu", "menuone", "noinsert"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.guicursor = "i:block"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smarttab = true
vim.opt.smoothscroll = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smartindent = true
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.smartcase = true
-- vim.opt.showmatch = true
-- vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 15

vim.wo.signcolumn = "yes"

-- Disable netrw for nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Custom icons for lsp diagnostics
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	virtual_text = false,
})

-- Sane keybinds
vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>p", '"+p', {})
vim.keymap.set("n", "<leader>p", '"+p', {})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move visual selection up n down... Hail Primeagen
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", {})

-- Force use hjkl
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move"<CR>')

vim.keymap.set("i", "<left>", '<cmd>echo "Use h to move"<CR>')
vim.keymap.set("i", "<right>", '<cmd>echo "Use l to move"<CR>')
vim.keymap.set("i", "<up>", '<cmd>echo "Use k to move"<CR>')
vim.keymap.set("i", "<down>", '<cmd>echo "Use j to move"<CR>')

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Plugin configurations
require("lazy").setup({
	{
		-- Load the bling✨ first
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			compile = true,
			colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
			transparent = true,
			overrides = function(a)
				local b = a.theme
				return {
					Pmenu = { fg = b.ui.shade0, bg = b.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = b.ui.bg_p2 },
					PmenuSbar = { bg = b.ui.bg_m1 },
					PmenuThumb = { bg = b.ui.bg_p2 },
				}
			end,
		},
		init = function()
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
	{
		-- Status line
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_b = {
					{
						"branch",
						"diff",
						"diagnostics",
						icons_enabled = true,
						icon = "",
						padding = 1,
					},
				},
				lualine_x = { "encoding", "filetype" },
			},
		},
	},
	{
		-- File tree
		"nvim-tree/nvim-tree.lua",
		opts = {
			sort = { sorter = "case_sensitive" },
			view = { width = 30 },
			renderer = { group_empty = true },
			filters = { dotfiles = false },
		},
		keys = {
			{ "<leader>E", ":NvimTreeFocus<CR>", desc = "Focus nvim tree", silent = true },
			{ "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle nvim tree", silent = true },
		},
	},
	{
		-- Blank line indentation
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "│", tab_char = "│" },
			whitespace = { remove_blankline_trail = false },
			scope = { enabled = false },
		},
	},
	-- Stuff that does not require any configs
	{ "lewis6991/gitsigns.nvim", opts = {} }, -- Git signs
	{ "numToStr/Comment.nvim", opts = {} }, -- To toggle linewise/blockwise comments
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		-- Shows diagnostics info on a seperate window
		"folke/trouble.nvim",
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble" },
			{ "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
			{ "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc = "Trouble document diagnostics" },
			{ "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "Trouble quickfix" },
			{ "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "Trouble loclist" },
		},
	},
	{
		-- Better syntax highlighting
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "c", "lua", "go", "python" },
				sync_install = false,
				highlight = { enable = true },
			})
		end,
	},
	{
		-- Floating menu based find file/lsp stuff
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{
				"<leader><space>",
				"<cmd>Telescope buffers {sort_mru=true, ignore_current_buffer=true}<cr>",
				desc = "Switch Buffer",
			},
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files in current directory" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Show git commits" },
		},
		lazy = false,
	},
	{
		-- Autocompletion and helpers
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "rafamadriz/friendly-snippets" },
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local select_opts = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				window = {
					completion = {
						scrollbar = false,
					},
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = {
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						local col = vim.fn.col(".") - 1

						if cmp.visible() then
							cmp.select_next_item(select_opts)
						elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
							fallback()
						else
							cmp.complete()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item(select_opts)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lsp_signature_help" },
				}),
			})
		end,
	},
	-- LSP setup
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", opts = {} },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- Add any servers here for it to be preinstalled
			ensure_installed = {
				"gopls",
				"ruff",
				"basedpyright",
			},
			handlers = {
				-- Default setup for all LSP servers
				function(server_name)
					vim.api.nvim_create_autocmd("LspAttach", {
						desc = "LSP actions",
						callback = function(event)
							-- Keybinds available only when a handler is attached
							local opts = { buffer = event.buf }
							-- Trigger code completion
							vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)
							vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
							vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
							vim.keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<cr>", opts)
							vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
							vim.keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", opts)
							vim.keymap.set("n", "gl", "<cmd>Telescope diagnostics<cr>") -- Trouble does the same

							vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
							vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
							vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
							vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
							vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

							-- Inlay hints for supported handlers
							-- local id = vim.tbl_get(event, "data", "client_id")
							-- local client = id and vim.lsp.get_client_by_id(id)
							-- if client == nil or not client.supports_method("textDocument/inlayHint") then
							-- 	return
							-- end
							-- vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
						end,
					})
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities =
						vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["basedpyright"] = function()
					-- Overrides for specific ones
					require("lspconfig").basedpyright.setup({
						settings = {
							basedpyright = {
								analysis = {
									reportUnreachable = false,
									typeCheckingMode = "off",
								},
							},
						},
					})
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						settings = {
							gopls = {
								semanticTokens = false,
								analyses = {
									unusedparams = true,
								},
								staticcheck = true,
							},
						},
					})
				end,
			},
		},
	},
	{
		-- Better formatting
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<F3>",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = { python = { "ruff_format" }, go = { "gofmt" }, lua = { "stylua" } },
			format_on_save = false,
			formatters = {},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}) -- Lazy ends

-- Autocmds
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	callback = function()
		for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(winid).zindex then
				return
			end
		end
		vim.diagnostic.open_float({
			scope = "cursor",
			focusable = false,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
			},
		})
	end,
})
