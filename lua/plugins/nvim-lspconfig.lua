local lspconfig_defaults = require('lspconfig').util.default_config
local util = require 'lspconfig.util'
local cmp = require('cmp')
local port = os.getenv 'GDScript_Port' or '6005'
local cmd = { 'ncat', 'localhost', port }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}


lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,

	require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}
	end,
})

-- CCLS
require'lspconfig'.ccls.setup({
    default_config ={
        cmd = {'ccls'},
        filetypes ={'c','cpp','objc','cuda'},
        root_dir = function(fname)
            return util.root_pattern('compile_commands.json', '.ccls')(fname)
                or vim.fs.dirname(vim.fs.find('.git', {path = fname, upward = true})[1])
        end,
        offset_encoding = 'utf-32',
        single_file_support = false,
    },
})

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
})

-- Ruby

require'lspconfig'.ruby_lsp.setup({
    default_config = {
        cmd = {'ruby_lsp'},
        filetypes = { 'ruby', 'eruby' },
        root_dir = util.root_pattern('Gemfile', '.git'),
        init_options = {
            formatter = 'auto',
        },
        single_file_support = true,
    },
})

-- GDscript
require'lspconfig'.gdscript.setup({
    default_config = {
        cmd = cmd,
        filetypes = { 'gd', 'gdscript', 'gdscript3' },
        root_dir = util.root_pattern('project.godot', '.git'),
        on_attach = function(client, bufnr)
            vim.fn.serverstart('127.0.0.1:6005')
        end
    },
    docs = {
        description = [[
https://github.com/godotengine/godot

Language server for GDScript, used by Godot Engine.
]],
    },
})
-- So Godot can open Nvim
if vim.fn.filereadable(vim.fn.getcwd() .. '/project.godot') == 1 then
    vim.fn.serverstart('127.0.0.1:6004')
end


-- Html
require'lspconfig'.html.setup{
    capabilities = capabilities,
    default_config = {
        cmd = {"vscode-html-language-server", "--stdio" },
        filetypes = { 'html', 'templ' },
        root_dir = util.root_pattern('package.json', '.git'),
        single_file_support = true,
        settings = {},
        init_options = {
            provideFormatter = true,
            embeddedLanguages = { css = true, javascript = true },
            configurationSection = { 'html', 'css', 'javascript' },
        },

    },
}

-- CSS
require'lspconfig'.cssls.setup({
    capabilities = capabilities,
    default_config = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_dir = util.root_pattern('package.json', '.git'),
        single_file_support = true,
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
        },
  },
})

-- Javascript

require'lspconfig'.ts_ls.setup({
    default_config = {
        init_options = { hostInfo = 'neovim' },
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
        root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
        single_file_support = true,
    },
})

-- C sharp
require'lspconfig'.csharp_ls.setup({
	default_config = {
		cmd = { 'csharp-ls' },
		root_dir = function(fname)
			return util.root_pattern '*.sln'(fname) or util.root_pattern '*.csproj'(fname)
		end,
		filetypes = { 'cs' },
		init_options = {
            automaticworkspaceinit = true,
		},
	},
	docs = {
		description = [[
    ]],
	},
})

-- HTML 
require'lspconfig'.html.setup({
    default_config = {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html', 'templ' },
        root_dir = util.root_pattern('package.json', '.git'),
        single_file_support = true,
        settings = {},
        init_options = {
            provideFormatter = true,
            embeddedLanguages = { css = true, javascript = true },
            configurationSection = { 'html', 'css', 'javascript' },
        }
    },
})
-- PYTHON
require'lspconfig'.pylsp.setup({
    default_config = {
        cmd = { 'pylsp' },
        filetypes = { 'python' },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" ),
        single_file_support = true,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = {'W391'},
                        maxLineLength = 100
                    },
                },
            },
        },
    },
})

-- CSS
require'lspconfig'.cssls.setup({
    default_config = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_dir = util.root_pattern('package.json', '.git'),
        single_file_support = true,
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
        },
    },
})
-- Lua
require'lspconfig'.lua_ls.setup({
    default_config = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_dir = function(fname)
            local root = util.root_pattern(unpack(root_files))(fname)
            if root and root ~= vim.env.HOME then
                return root
            end
            local root_lua = util.root_pattern 'lua/'(fname) or ''
            local root_git = util.find_git_ancestor(fname) or ''
            if root_lua == '' and root_git == '' then
                return
            end
            return #root_lua >= #root_git and root_lua or root_git
        end,
        single_file_support = true,
        log_level = vim.lsp.protocol.MessageType.Warning,
    },
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
})
