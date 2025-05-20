return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        cmake = { 'cmake_format' },
        json = { "jq" },
        lua = { 'stylua' },
        bash = { 'shfmt' },
        python = { 'black', 'isort' },
      },
    },
  },
}
