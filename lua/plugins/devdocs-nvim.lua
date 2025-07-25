return {
  'maskudo/devdocs.nvim',
  lazy = false,
  dependencies = {
    'folke/snacks.nvim',
  },
  cmd = { 'DevDocs' },
  keys = {
    {
      '<leader>io',
      mode = 'n',
      '<cmd>DevDocs get<cr>',
      desc = 'Get Devdocs',
    },
    {
      '<leader>ii',
      mode = 'n',
      '<cmd>DevDocs install<cr>',
      desc = 'Install Devdocs',
    },
    {
      '<leader>iv',
      mode = 'n',
      function()
        local devdocs = require 'devdocs'
        local installedDocs = devdocs.GetInstalledDocs()
        vim.ui.select(installedDocs, {}, function(selected)
          if not selected then
            return
          end
          local docDir = devdocs.GetDocDir(selected)
          -- prettify the filename as you wish
          Snacks.picker.files { cwd = docDir }
        end)
      end,
      desc = 'Get Devdocs',
    },
    {
      '<leader>id',
      mode = 'n',
      '<cmd>DevDocs delete<cr>',
      desc = 'Delete Devdoc',
    },
    {
      '<leader>is',
      mode = 'n',
      function()
        local devdocs = require 'devdocs'
        local symbol = vim.fn.expand('<cword>')
        local installedDocs = devdocs.GetInstalledDocs()
        local Snacks = require 'snacks'
        local matches = {}

        for _, doc in ipairs(installedDocs) do
          local docDir = devdocs.GetDocDir(doc)
          -- You may want to implement a smarter search here
          -- For now, just collect all docs for manual selection
          table.insert(matches, { doc = doc, dir = docDir })
        end

        vim.ui.select(matches, {
          prompt = 'Select documentation for ' .. symbol,
          format_item = function(item) return item.doc end,
        }, function(selected)
          if selected then
            Snacks.picker.files { cwd = selected.dir }
          end
        end)
      end,
      desc = 'Search DevDocs for symbol under cursor in installed docs',
    },
  },
  opts = {
    ensure_installed = {
      'go',
      'html',
      -- "dom",
      'http',
      -- "css",
      -- "javascript",
      -- "rust",
      -- some docs such as lua require version number along with the language name
      -- check `DevDocs install` to view the actual names of the docs
      'lua~5.1',
      -- "openjdk~21"
    },
  },
}
