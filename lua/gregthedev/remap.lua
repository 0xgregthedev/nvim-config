local keymap = require("gregthedev.keymap")
local fterm = require("FTerm")

local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap
local vnoremap = keymap.vnoremap
local nmap = keymap.nmap

inoremap("kj", "<Esc>")
inoremap("KJ", "<Esc>")

vnoremap("y", '"+y')
vnoremap("Y", '"+Y')

nnoremap("yy", '"+yy')
nnoremap("YY", '"+YY')
nnoremap("p", '"+p')
nnoremap("P", '"+P')

nmap("<leader>fr", ":%s///gc<left><left><left><left>")
nmap("<leader>qfr", ":cdo %s///cg<left><left><left><left>")

nnoremap("<leader>fd", "<cmd>find .<CR>")
nnoremap("<leader>sf", "<cmd>:w!<CR>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fs", "<cmd>:Telescope live_grep<CR>")
nnoremap("<leader>fh", "<cmd>:Telescope buffers<CR>")
nnoremap("<leader>bh", "<cmd>:Telescope git_bcommits<CR>")
nnoremap("<leader>fc", "<cmd>:ForgeCoverage<CR>")
nnoremap("<leader>cd", ":cd ")
nnoremap("<leader>so", "<cmd>:so<CR>")

vim.api.nvim_create_user_command('ForgeCoverage', function(opts)
    local functions = {
        start = fterm.run(
            "forge coverage --report summary --report lcov && lcov -o lcov.info --remove lcov.info --rc lcov_branch_coverage=1 --rc lcov_function_coverage=1 \"test/*\" && genhtml lcov.info -o html --function-coverage --branch-coverage && google-chrome --new-window html/index.html"),
        close = fterm.close,
        exit = fterm.exit
    }
end, {nargs = 0, bang = true})

vim.api.nvim_create_user_command('LazyGit', function(opts)
    local functions = {
        start = fterm.run("lazygit"),
        close = fterm.close,
        exit = fterm.exit
    }
end, {nargs = 0, bang = true})

nnoremap("<leader>gg", "<cmd>:LazyGit<CR>")

nnoremap("<space>fa", "<cmd>:Neoformat<CR>")

vim.keymap.set("n", "<leader>ft", fterm.toggle)
vim.keymap.set("t", "<leader>ft", fterm.toggle)

nnoremap("<leader>td", "<cmd>:Telescope diagnostics<CR>")
nnoremap("<leader>bw", "<cmd>wincmd p<CR>")

nnoremap("<leader>bb", "<cmd>:b#<CR>")

vim.keymap.set("n", "<leader>ch", "<cmd>:NeoChisel start<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>:NeoChisel exit<CR>")
vim.keymap.set("t", "<C-c>", "<cmd>:NeoChisel exit<CR>")

vim.api.nvim_create_user_command('NeoChisel', function(opts)
    local functions = {
        start = ChiselStart,
        close = fterm.close,
        exit = fterm.exit
    }
    functions[opts.fargs[1]]()
end, {nargs = 1, bang = true})

function ChiselStart()

    local file = vim.api.nvim_buf_get_name(0)

    local cmd = ""
    for line in io.lines(file) do

        if line:find("SPDX%-") or line:find("pragma solidity") then
            goto continue
        end

        cmd = cmd .. line

        ::continue::
    end
    cmd = cmd .. "contract Repl{}"

    local fterm = require("FTerm")
    fterm.run("chisel")

    fterm.run(cmd)
end

