local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end


local lspconfig = require("lspconfig")
-- Add servers
local servers = {"jsonls","sumneko_lua"}

-- TODO: deprecated -> remove
-- require"user.lsp.lsp-installer"
-- require("user.lsp.handlers").setup()
-- require "user.lsp.null-ls"
