
local setup_mason = function()
	local is_windows = require("configs").is_windows

	local mason_registry = require("mason-registry")
	require("lspconfig.ui.windows").default_options.border = "rounded"

	require("mason").setup{
		ui = {
			border = "single",
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		},
	}

	-- Additional plugins for pylsp
	mason_registry:on(
		"package:install:success",
		vim.schedule_wrap(function(pkg)
			if pkg.name ~= "python-lsp-server" then
				return
			end

			local venv = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv"
			local python = is_windows and venv .. "/Scripts/python.exe" or venv .. "/bin/python"
			local black = is_windows and venv .. "/Scripts/black.exe" or venv .. "/bin/black"
			local ruff = is_windows and venv .. "/Scripts/ruff.exe" or venv .. "/bin/ruff"

			require("plenary.job")
				:new({
					command = python,
					args = {
						"-m",
						"pip",
						"install",
						"-U",
						"--disable-pip-version-check",
						"python-lsp-black",
						"python-lsp-ruff",
						"pylsp-rope",
					},
					cwd = venv,
					env = { VIRTUAL_ENV = venv },
					on_exit = function()
						if vim.fn.executable(black) == 1 and vim.fn.executable(ruff) == 1 then
							vim.notify(
								"Finished installing pylsp plugins",
								vim.log.levels.INFO,
								{ title = "[lsp] Install Status" }
							)
						else
							vim.notify(
								"Failed to install pylsp plugins. [Executable not found]",
								vim.log.levels.ERROR,
								{ title = "[lsp] Install Failure" }
							)
						end
					end,
					on_start = function()
						vim.notify(
							"Now installing pylsp plugins...",
							vim.log.levels.INFO,
							{ title = "[lsp] Install Status", timeout = 6000 }
						)
					end,
					on_stderr = function(_, msg_stream)
						vim.notify(msg_stream, vim.log.levels.ERROR, { title = "[lsp] Install Failure" })
					end,
				})
				:start()
		end)
	)
end

local setup_mason_lspconfig = function()
	local diagnostics_virtual_text = require("configs").diagnostics_virtual_text

	local nvim_lsp = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	require("lspconfig.ui.windows").default_options.border = "rounded"

	require("mason-lspconfig").setup{
		ensure_installed = require("configs").lsp_deps,
	}

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = true,
		underline = true,
		virtual_text = diagnostics_virtual_text,
		-- set update_in_insert to false bacause it was enabled by lspsaga
		update_in_insert = false,
	})

	local opts = {
		-- capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
	---A handler to setup all servers defined under `completion/servers/*.lua`
	---@param lsp_name string
	local function mason_lsp_handler(lsp_name)
		local ok, custom_handler = pcall(require, "configs.lsp-servers." .. lsp_name)
		-- Use preset if there is no user definition
		if not ok then
			-- Default to use factory config for server(s) that doesn't include a spec
			nvim_lsp[lsp_name].setup(opts)
			return
		elseif type(custom_handler) == "function" then
			--- Case where language server requires its own setup
			--- Make sure to call require("lspconfig")[lsp_name].setup() in the function
			--- See `clangd.lua` for example.
			custom_handler(opts)
		elseif type(custom_handler) == "table" then
			nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
		else
			vim.notify(
				string.format(
					"Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
					lsp_name,
					type(custom_handler)
				),
				vim.log.levels.ERROR,
				{ title = "nvim-lspconfig" }
			)
		end
	end

	mason_lspconfig.setup({ mason_lsp_handler })
end

return {
    "neovim/nvim-lspconfig",
    event = {"CursorHold", "CursorHoldI" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        {
            "Jint-lzxy/lsp_signature.nvim",
        },
    },
    config = function()
        local nvim_lsp = require("lspconfig")
        setup_mason()
        setup_mason_lspconfig()

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

        vim.api.nvim_command([[LspStart]])
    end,
}
