local lspconfig = require('lspconfig')

local function on_attach(_, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
end

lspconfig.pyright.setup{ on_attach = on_attach }
lspconfig.tsserver.setup{ on_attach = on_attach }
lspconfig.lua_ls.setup{ on_attach = on_attach }
lspconfig.cmake.setup{ on_attach = on_attach }

lspconfig.ccls.setup {
    on_attach = on_attach;
    init_options = {
        -- cache = {
        --     directory = ".ccls-cache";
        -- };
        compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        clang = {
            resourceDir = "/usr/lib/llvm-18/lib/clang/18";
            excludeArgs = { "-frounding-math"};
            extraArgs = {"-std=c++17"};
        };
    };
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());
    root_dir = function(fname)
        return lspconfig.util.root_pattern('compile_commands.json', '.ccls', 'CMakeLists.txt', '.git')(fname) or vim.fn.getcwd()
    end;
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
  }
)

