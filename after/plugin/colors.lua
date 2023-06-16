
function MakeSomeColor(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	-- Transparant BG:
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

MakeSomeColor()
