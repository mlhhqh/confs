-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {
    "ray-x/lsp_signature.nvim",
    config = function() require "lsp_signature".on_attach() end,
    event = "BufRead"
  },
  {
    '00sapo/visual.nvim',
    event = "VeryLazy"
  },
  {
    "HiPhish/rainbow-delimiters.nvim"
  },
  {
    "lewis6991/gitsigns.nvim"
  },
  {
    "nvim-tree/nvim-tree.lua"
  },
  {
    "folke/trouble.nvim"
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "jghauser/fold-cycle.nvim",
    opts = {
      open_if_max_closed = false,
    }
  }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}
lvim.builtin.which_key.mappings["w"] = {
  name = "Window",
  a = { "", "Jaja" }
}

lvim.builtin.bufferline.active = false

vim.opt.cmdheight = 0
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.keymap.set("n", "<C-s>", function() require("which-key").show(" ", { mode = "n" }) end)
vim.keymap.set("n", "g", function() require() end)
vim.keymap.set("n", "<Tab>", function() require("fold-cycle").open() end)
vim.keymap.set("n", "<s-Tab>", function() require("fold-cycle").close() end)
vim.keymap.set("n", "f", function() require("which-key").show("x", { mode = "n" }) end)
local wk = require("which-key")
wk.register({x = {
  name = "file",
  y = {"", "Jeff"}
}}, {})
