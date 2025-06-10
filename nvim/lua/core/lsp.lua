-- Check if cmp_nvim_lsp is available
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = vim.lsp.protocol.make_client_capabilities()

if cmp_nvim_lsp_ok then
	capabilities = cmp_nvim_lsp.default_capabilities()
end

-- python lsp
require('lspconfig').pylsp.setup({
	capabilities = capabilities,
})

-- Java lsp
require('lspconfig').jdtls.setup({
	capabilities = capabilities,
	cmd = {'jdtls'},
	root_dir = require('lspconfig.util').root_pattern(
		'.git', 
		'mvnw', 
		'gradlew', 
		'pom.xml', 
		'build.gradle',
		'build.gradle.kts'
	),
})

-- c and c++ lsp
require('lspconfig').clangd.setup({
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
	},
})

-- lua lsp
require('lspconfig').lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT', -- Neovim uses LuaJIT
			},
			diagnostics = {
				globals = {'vim'}, -- Recognize 'vim' global in Neovim configs
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- Disable third-party checking
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
