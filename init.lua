
require("flo")

vim.g.python3_host_prog = '/usr/bin/python3.12'
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer'
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

-- Store current state
local is_transparent = false

-- Toggle background transparency
local function toggle_background()
	if is_transparent then
		-- Solid background
		vim.api.nvim_set_hl(0, "Normal", { bg = "#1d2021" }) -- Gruvbox dark0_hard
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021" })
		is_transparent = false
		print("Background set to solid")
	else
		-- Transparent background
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		is_transparent = true
	end
end

-- Command to toggle background
vim.api.nvim_create_user_command("ToggleBackground", toggle_background, {})

-- Ensure transparency is applied after the colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		if is_transparent then
			vim.defer_fn(function()
				vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			end, 10)
		end
	end,
})

vim.keymap.set("n", "<leader>tt", toggle_background)

toggle_background()
