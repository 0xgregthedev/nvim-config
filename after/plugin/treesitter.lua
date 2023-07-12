require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "rust", "solidity", "javascript", "typescript" },
        sync_install = true,
        auto_install = true,
        highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = true
        }
}
