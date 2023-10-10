-- Mappings.
--
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>qf', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  --if not vim.tbl_isempty(vim.fn.getqflist()) then
  vim.diagnostic.setqflist({}, 'r', {
    title = 'Diagnostics',
    severity_sort = true,
  })
  
 --end
end
)
end

--vim.api.nvim_create_autocmd( "InsertEnter", {
---- or vim.api.nvim_create_autocmd({"BufNew", "TextChanged", "TextChangedI", "TextChangedP", "TextChangedT"}, {
--  callback = function(args)
--    vim.diagnostic.disable(args.buf)
--  end
--})

--local debounce = 1500
--local hit = false
--
--local timer = vim.uv.new_timer()
--timer:start(debounce, debounce, vim.schedule_wrap(function()
-- if not hit then
--  vim.diagnostic.setqflist({}, 'r', {
--    title = 'Diagnostics',
--    severity_sort = true,
--  })
-- vim.cmd("wincmd k")
-- end
--
-- hit = false
--
--end))
--
--
--vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI", "TextChangedP"}, {
--  callback = function(args)
--    hit = true
--  end
--})

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
local lspconfig = require('lspconfig')

lspconfig['tsserver'].setup{
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern('package.json', 'yarn.lock'),
    flags = lsp_flags,
}
lspconfig['solidity_ls_nomicfoundation'].setup{
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern('foundry.toml', 'package.json', 'yarn.lock'),
    flags = lsp_flags,
}

lspconfig['gopls'].setup{
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern('go.mod'),
    flags = lsp_flags,
}
lspconfig['graphql'].setup{
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern('schema.graphql', 'tsconfig.json', 'turbo.json'),
    filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" },
    flags = lsp_flags,
}

--lspconfig['graphql'].setup{
--    on_attach = on_attach,
--    root_dir = lspconfig.util.root_pattern('schema.graphql');
--    flags = lsp_flags,
--}
lspconfig['rust_analyzer'].setup{
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern('Cargo.toml', 'Cargo.lock', 'main.rs', 'lib.rs'),
    diagnostics = {
        enable = true,
    },
    -- Server-specific settings...
    flags = lsp_flags,
}

