local fn = vim.fn
local cmd = vim.cmd
local api = vim.api



-- https://github.com/mhinz/vim-grepper
--vim.g.grepper = {tools = {'rg', 'grep'}, searchreg = 1}
--cmd(([[
--    aug Grepper
--        au!
--        au User Grepper ++nested %s
--    aug END
--]]):format([[call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})]]))
--
---- try `gsiw` under word
--cmd([[
--    nmap gs  <plug>(GrepperOperator)
--    xmap gs  <plug>(GrepperOperator)
--]])

-- https://github.com/neoclide/coc.nvim
-- if you use coc-fzf, you should disable its CocLocationsChange event
-- to make bqf work for <Plug>(coc-references)

-- vim.schedule(function()
--     cmd('au! CocFzfLocation User CocLocationsChange')
-- end)
vim.g.coc_enable_locationlist = 0
cmd([[
    aug Coc
        au!
        au User CocLocationsChange lua _G.jumpToLoc()
    aug END
]])

cmd([[
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> <leader>qd <Cmd>lua _G.diagnostic()<CR>
]])

-- just use `_G` prefix as a global function for a demo
-- please use module instead in reality
function _G.jumpToLoc(locs)
    locs = locs or vim.g.coc_jump_locations
    fn.setloclist(0, {}, ' ', {title = 'CocLocationList', items = locs})
    local winid = fn.getloclist(0, {winid = 0}).winid
    if winid == 0 then
        cmd('abo lw')
    else
        api.nvim_set_current_win(winid)
    end
end

