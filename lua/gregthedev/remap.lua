local keymap = require("gregthedev.keymap")

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

nnoremap("<leader>fd", "<cmd>find .<CR>")
nnoremap("<leader>sf", "<cmd>:w!<CR>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fs", "<cmd>:Telescope live_grep<CR>")
nnoremap("<leader>fh", "<cmd>:Telescope buffers<CR>")
nnoremap("<leader>bh", "<cmd>:Telescope git_bcommits<CR>")
nnoremap("<leader>gh", "<cmd>:Telescope git_commits<CR>")
nnoremap("<leader>gs", "<cmd>:Telescope git_status<CR>")
nnoremap("<leader>gb", "<cmd>:Telescope git_branches<CR>")

nnoremap("<leader>st", ":!git stage ")
nnoremap("<leader>gc", ":!git commit -m ''<left>")

nnoremap("<space>fa", "<cmd>:Neoformat<CR>")

local fterm = require("FTerm")

vim.keymap.set("n", "<leader>ft", fterm.toggle)
vim.keymap.set("t", "<leader>ft", fterm.toggle)


nnoremap("<leader>td", "<cmd>:Telescope diagnostics<CR>")
nnoremap("<leader>bw", "<cmd>wincmd p<CR>")

nnoremap("<leader>bb", "<cmd>:b#<CR>")

vim.keymap.set("n", "<leader>ch", "<cmd>:NeoChisel start<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>:NeoChisel exit<CR>")
vim.keymap.set("t", "<C-c>", "<cmd>:NeoChisel exit<CR>")


vim.api.nvim_create_user_command('NeoChisel', 
  function(opts)
    local functions = {
      start = ChiselStart,
      close = fterm.close,
      exit = fterm.exit
    }
    functions[opts.fargs[1]]()
  end,
  { nargs = 1, bang = true})


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



