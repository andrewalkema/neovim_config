-- lots of stuff from here https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.breakindent = true --Enable break indent

vim.opt.expandtab = true --Convert tabs to spaces
vim.opt.shiftwidth = 4 --Amount to indent with << and >

vim.opt.tabstop = 4 --How many spaces are shown per tab
vim.opt.softtabstop = 4 --How many spaces are applied when pressing tab

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true --Keep indentation from previous line

vim.opt.cursorline = true
vim.opt.cursorcolumn = false -- set to true to see column highlighted

vim.opt.undofile = true --Store undos between session

vim.opt.mouse = "a" --use mouse, nice for splits

vim.opt.showmode = false --dont' show mode since mine statusline does it

-- case insensitive searching UNLESS I have at least one cap, then real match
vim.opt.ignorecase = true
vim.opt.smartcase = true

--this makes that column to the left always show up, has errors and stuff.  This way if an error pops up it won't suddenly shift everything
vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.scrolloff = 10
vim.opt.cmdheight = 1

--Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
