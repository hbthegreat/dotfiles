return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup(
      {
          ensure_installed = { "lua_ls", "ts_ls", "angularls", "dockerls", "docker_compose_language_service", "tailwindcss", "html", "biome", "jsonls", "cssls", "gitlab_ci_ls", "spectral" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.angularls.setup({})
      lspconfig.dockerls.setup({})
      lspconfig.docker_compose_language_service.setup({})
      lspconfig.tailwindcss.setup({})
      lspconfig.html.setup({})
      lspconfig.biome.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.cssls.setup({})
      lspconfig.gitlab_ci_ls.setup({})
      lspconfig.spectral.setup({})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
