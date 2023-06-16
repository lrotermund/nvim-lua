local lsp = require('lsp-zero')

lsp.preset("recommended")

local on_attach = function ()
    local opts = {buffer = 0}
    vim.diagnostic.config({
        virtual_text = true,
    })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics<cr>", opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
end

lsp.ensure_installed({
	'intelephense',
	'gopls',
	'terraformls',
	'cssls',
	'jsonls',
	'yamlls',
	'lua_ls',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping {
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}
})

local intelephense_license = function()
	local f = assert(io.open(os.getenv("HOME") .. "/intelephense/licence.txt", "rb"))
	local content = f:read("*a")
	f:close()

	return string.gsub(content, "%s+", "")
end

lsp.set_preferences({
	sign_icons = { }
})

lsp.configure("intelephense", {
    on_attach = on_attach,
    init_options = {
	    licenceKey = intelephense_license()
    }
})

lsp.setup()
