return {
  "github/copilot.vim",
  config = function()
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_assume_mapped = true
  end
}
