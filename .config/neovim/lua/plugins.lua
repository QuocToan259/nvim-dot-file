local status, packer = pcall(require, 'packer')
if (not status) then
        print("Packer is not installed")
        return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
        use 'wbthomason/packer.nvim'
        use {
            'craftzdog/solarized-osaka.nvim', requires = { 'tjdevries/colorbuddy.nvim' }
        }
        use {
                'nvim-lualine/lualine.nvim',
                requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }
        use 'andweeb/presence.nvim'
        use 'neovim/nvim-lspconfig'
        use 'onsails/lspkind-nvim'
        use 'L3MON4D3/LuaSnip'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/nvim-cmp'
end)
