vim.o.number = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.termguicolors = true

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hlsearch = true
vim.o.completeopt = "menu"

return {
    is_windows = false,
    diagnostics_virtual_test = true,
    lsp_deps = {
        "bashls",
        "clangd",
        "lua_ls",
        "pylsp",
        "purescriptls",
    },
}
