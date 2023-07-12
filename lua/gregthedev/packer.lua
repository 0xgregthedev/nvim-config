vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
        --Packer can manage itself
        use 'wbthomason/packer.nvim'
        use {"akinsho/toggleterm.nvim", tag = '*', config = function()
          require("toggleterm").setup()
        end}
        use 'folke/tokyonight.nvim'
        use 'neovim/nvim-lspconfig'
        use 'jose-elias-alvarez/null-ls.nvim'
        use 'sbdchd/neoformat'
        use 'BurntSushi/ripgrep'
        use 'pedrommaiaa/vim-huff'
        use "numToStr/FTerm.nvim"
        use {
          "hrsh7th/nvim-cmp",
          requires = {
              "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
              'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',
              'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
              'hrsh7th/cmp-emoji', 'f3fora/cmp-spell', 
          }
        }
        use {'junegunn/fzf', run = function()
            vim.fn['fzf#install']()
        end
        }
        use {'kevinhwang91/nvim-bqf', ft = 'qf'}
        use {
                'nvim-lualine/lualine.nvim',
                requires = { 'kyazdani42/nvim-web-devicons', opt = true}
        }
        use {
                 'nvim-telescope/telescope.nvim', tag = '0.1.0',
                 requires = {{ 'nvim-lua/plenary.nvim'}}
        }
        use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate'
        }
end)
