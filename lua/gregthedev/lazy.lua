local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'github/copilot.vim', 'folke/tokyonight.nvim', 'folke/trouble.nvim',
    'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim',
    'sbdchd/neoformat', 'BurntSushi/ripgrep', 'pedrommaiaa/vim-huff',
    "numToStr/FTerm.nvim", {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lua', 'octaltree/cmp-look', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc', 'hrsh7th/cmp-emoji', 'f3fora/cmp-spell'
        }
    }, {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }, {
        'junegunn/fzf',
        build = function() vim.fn['fzf#install']() end,
        {'kevinhwang91/nvim-bqf', dependencies = {'junegunn/fzf'}},
        'nvim-lualine/lualine.nvim',
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.3',
            dependencies = {{'nvim-lua/plenary.nvim'}}
        },
        {'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
        {
            'pwntester/octo.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim'
            },
            config = function()
                require"octo".setup({
                    suppress_missing_scope = {projects_v2 = true}
                })
            end
        }
    }
})
