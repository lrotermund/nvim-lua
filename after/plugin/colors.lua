
function MakeSomeColor(color)
    -- Themes:
    -- rose-pine
    -- everforest
	color = color or "everforest"
	vim.cmd.colorscheme(color)

	-- Transparant BG:
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

MakeSomeColor()
