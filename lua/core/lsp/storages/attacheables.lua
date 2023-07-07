local mem_storage = require "shared.storages.mem"

local attacheable_storage = mem_storage.new(
    {
        {
            name = "highlight_symbols",
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd [[
                        hi! LspReferenceRead  guibg=#404040
                        hi! LspReferenceText  guibg=#404040
                        hi! LspReferenceWrite  guibg=#404040
                    ]]
                    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
                    vim.api.nvim_clear_autocmds {
                        buffer = bufnr,
                        group = "lsp_document_highlight"
                    }
                    vim.api.nvim_create_autocmd("CursorHold", {
                        callback = vim.lsp.buf.document_highlight,
                        buffer = bufnr,
                        group = "lsp_document_highlight",
                        desc = "Document Highlight"
                    })
                    vim.api.nvim_create_autocmd("CursorMoved", {
                        callback = vim.lsp.buf.clear_references,
                        buffer = bufnr,
                        group = "lsp_document_highlight",
                        desc = "Clear All the References"
                    })
                end
            end
        },
    }
)

return attacheable_storage
