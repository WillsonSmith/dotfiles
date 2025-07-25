vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.server_capabilities.hoverProvider then
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { buffer = args.buf })
    end

    if client.server_capabilities.signatureHelpProvider then
      vim.keymap.set({ "n", "i" }, "<c-k>", vim.lsp.buf.signature_help, { buffer = args.buf })
    end

    if client.server_capabilities.declarationsProvider then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
    end

    if client.server_capabilities.definitionProvider then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    end

    if client.server_capabilities.typeDefinitionProvider then
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = args.buf })
    end

    if client.server_capabilities.implementationProvider then
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf })
    end

    if client.server_capabilities.renameProvider then
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
    end

    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = args.buf })
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = args.buf })

    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { buffer = args.buf })
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count = -1, float = true}) end, { buffer = args.buf })
  end
})
