require("lint").linters_by_ft = {
  -- python = { "flake8" },
  --cpp = {"clangd"}
}

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
