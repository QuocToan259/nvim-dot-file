local api = vim.api
local opt = vim.opt


vim.cmd('autocmd!')

-- encoding setting
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
vim.cmd[[colorscheme solarized-osaka]]

-- display setting
vim.wo.number = true
opt.title = true
opt.cmdheight = 1
opt.wrap = false
opt.laststatus = 2

-- editing setting
opt.autoindent = true
opt.hlsearch = true
opt.expandtab = true
opt.scrolloff = 10
opt.mouse = ''

-- other setting
opt.shell = 'pwsh'
opt.backupskip = { '*.tmp', '*.bak', 'C:\\Temp\\*' }
opt.inccommand = 'split'
opt.ignorecase = true
opt.smarttab = true
opt.breakindent = true
opt.tabstop = 2
opt.ai = true
opt.si = true
opt.backspace = 'start,eol,indent'
opt.path:append { '**' }
opt.wildignore:append { '*/node_modules/*' }


-- undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        command = "set nopaste"
})

-- transparent background
api.nvim_set_hl(0, 'Normal', { bg = 'none' })
api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

