return {
    "nvim-tree/nvim-tree.lua",
    cmd = {
        "NvimTreeToggle",
        "NvimTreeOpen",
        "NvimTreeFindFile",
        "NvimTreeFindFileToggle",
        "NvimTreeRefresh",
    },
    config = function ()
        vim.g.loaded_netrw = 1
        vim.g.loaded_newrwPlugin = 1

        require("nvim-tree").setup()
    end
}
