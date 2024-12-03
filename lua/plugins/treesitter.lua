require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "vim", "javascript", "c_sharp", "gdscript"},

	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = false },
})


require("nvim-treesitter.install").update({with_sync = true})
require 'nvim-treesitter.install'.compilers = { "clang" }
