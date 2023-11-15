---require('lspconfig').tsserver.setup{}
---require('lspconfig').rust_analyzer.setup{}

-- -- /////////////////////////////////////////////////////////////
-- -- all below pasted from https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
-- 
-- -- Mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
 vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
 vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
 vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
 vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
 -- Use an on_attach function to only map the following keys
 -- after the language server attaches to the current buffer
 -- turn on/off inline diagnostics
vim.diagnostic.config({
  virtual_text = false, 
  signs = false, 
  underline= true, 
})

-- set the root_dir to '.git' so each server attaches to the project
-- directory. This value needs to be a unique filetype at the top level 
-- otherwise it searches for the deepest package.json and doesn't find
-- references in surrounding folders in the project when using go_to_reference
 local nvim_lsp = require 'lspconfig'
 local root_dir = nvim_lsp.util.root_pattern('.git') 

 local on_attach = function(client, bufnr)
 -- Enable completion triggered by <c-x><c-o>
 vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

 vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(

   vim.lsp.handlers.hover, {
     -- Use a sharp border with when using hover
     border = "single"
   }
 )

 vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(

   vim.lsp.handlers.signature_help, {
     -- Use a sharp border when using signature help
     border = "single"
   }
 )
 -- Mappings.
 -- See `:help vim.lsp.*` for documentation on any of the below functions
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
 -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
 -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
 -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

 -- previous formatting settings, deprecated but kept here in case new version breaks
 --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

 --vim.api.nvim_buf_set_keymap(bufnr, 'i', 'kk', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
end

--- Use a loop to conveniently call 'setup' on multiple servers and
--- map buffer local keybindings when the language server attaches
local servers = {'tsserver', 'pyright', 'rust_analyzer'}
local nvim_lsp = require 'lspconfig'

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup{

    on_attach = on_attach,
    root_dir = root_dir,
    flags = {
      -- This will be the default in neovim 0.7
      debounce_text_changes = 150,
    }
  }
end
-- -- /////////////////////////////////////////////////////////////
