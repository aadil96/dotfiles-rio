-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.background = "dark"
vim.g.snacks_animate = false
-- something  about adding plugins.extras into my own config to preload some stuff...
vim.g.lazyvim_check_order = false

vim.opt.relativenumber = false
vim.opt.scrolloff = 8

-- Detect WSL (Lua)
local function is_wsl()
	if vim.fn.has("unix") == 1 and vim.fn.filereadable("/proc/version") == 1 then
		local lines = vim.fn.readfile("/proc/version")
		if lines and lines[1] and string.match(lines[1], "microsoft") then
			return true
		end
	end
	return false
end

-- Apply WSL clipboard config
if is_wsl() then
	-- Use unnamedplus
	vim.opt.clipboard = "unnamedplus"

	-- Setup clipboard provider similar to Vimscript g:clipboard mapping
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("\\r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("\\r", ""))',
		},
		cache_enabled = 0,
	}
end
