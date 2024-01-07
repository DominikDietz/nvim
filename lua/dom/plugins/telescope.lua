local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == "" then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown(),
            },
          },
          defaults = {
            file_ignore_patterns = { "node_modules" },
          },
        })
        require("telescope").load_extension("ui-select")
      end,
    },
  },
  config = function()
    pcall(require("telescope").load_extension, "fzf")
    vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

    vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files)
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
    vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string)
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
    vim.keymap.set("n", "<leader>fG", ":LiveGrepGitRoot<cr>")
    vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics)
    vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume)
    vim.keymap.set("n", "<leader>/", function()
      require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({ previewer = false })
      )
    end)
  end,
}
