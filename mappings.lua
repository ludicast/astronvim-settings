-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local get_file = function()
  local current_path = vim.fn.expand('%:p:h')
  local current_path_cmd = "./run.sh"
  if string.find(current_path, 'exercism/go') then
    current_path_cmd = "go test"
  end

  if string.find(current_path, 'exercism/ruby') then
    current_path_cmd = "ruby *_test.rb"
  end

  return ":! " .. current_path_cmd .. "<cr>"
end

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    ["<leader>s"] = { ":!exercism submit<cr>", desc = "submit exercise" },
    ["<leader><leader>"] = { get_file(), desc = "Run application" },
    ["<leader><cr>"] = { "<cmd>! ruby *_test.rb<cr>", desc = "Test application" },
    -- TODO: Add check I'm not on main
    ["<leader>u"] = { "<cmd>! git add . && git commit -m update; git push<cr>", desc = "upload idgaf" },
    ["<right>"] = { "<c-w>l", desc = "Move to right pane" },
    ["<left>"] = { "<c-w>h", desc = "Move to left pane" },
    ["<up>"] = { "<c-w>k", desc = "Move up" },
    ["<down>"] = { "<c-w>j", desc = "Move down" },
    -- end Nate
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
