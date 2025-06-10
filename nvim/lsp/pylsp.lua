
local lspconfig = require("lspconfig")

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          maxLineLength = 100,
        },
        -- You can disable other plugins if you want:
        mccabe = { enabled = true },
        pyflakes = { enabled = true },
      },
    },
  },
})
