vim.lsp.set_log_level("debug")
local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
        -- formatting
        if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_command [[augroup Format]]
                vim.api.nvim_command [[autocmd! * <buffer>]]
                vim.api.nvim_command [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })]]
                vim.api.nvim_command [[augroup END]]
        end
end

nvim_lsp.ts_ls.setup {
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "javascript", "typescript" },
        cmd = { "typescript-language-server", "--stdio" }
}

nvim_lsp.lua_ls.setup {
        on_attach = on_attach,
        settings = {
                Lua = {
                        diagnostics = {

                                globals = { 'vim' }
                        },

                        workspace = {

                                library = vim.api.nvim_get_runtime_file("", true)

                        },
                },
        },
}

nvim_lsp.anakin_language_server.setup {
        on_attach = on_attach,
        filetypes = { "python" },
        settings = {
                anakinls = {
                        pyflakes_errors = { "ImportStarNotPermitted", "UndefinedExport", "UndefinedLocal", "UndefinedName", "DuplicateArgument", "MultiValueRepeatedKeyLiteral", "MultiValueRepeatedKeyVariable", "FutureFeatureNotDefined", "LateFutureImport", "ReturnOutsideFunction", "YieldOutsideFunction", "ContinueOutsideLoop", "BreakOutsideLoop", "TwoStarredExpressions", "TooManyExpressionsInStarredAssignment", "ForwardAnnotationSyntaxError", "RaiseNotImplemented", "StringDotFormatExtraPositionalArguments", "StringDotFormatExtraNamedArguments", "StringDotFormatMissingArgument", "StringDotFormatMixingAutomatic", "StringDotFormatInvalidFormat", "PercentFormatInvalidFormat", "PercentFormatMixedPositionalAndNamed", "PercentFormatUnsupportedFormat", "PercentFormatPositionalCountMismatch", "PercentFormatExtraNamedArguments", "PercentFormatMissingArgument", "PercentFormatExpectedMapping", "PercentFormatExpectedSequence", "PercentFormatStarRequiresSequence" }
                }
        }
}

nvim_lsp.html.setup {
        on_attach = on_attach,
        filetypes = { "html" },
        cmd = { "vscode-html-language-server", "--stdio" },
        init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = {
                        css = true,
                        javascript = true,
                },
                provideFormatter = true,
        }
}


nvim_lsp.cssls.setup {
        on_attach = on_attach,
        filetypes = { "css", "scss" },
        cmd = { "vscode-css-language-server", "--stdio" }
}
