local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Autocommand that reloads neovim whenever the file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  use ("christoomey/vim-tmux-navigator") -- tmux & split window navigation
  use ("szw/vim-maximizer") -- maximizes and restores current window

  -- essential plugins
  use("tpope/vim-surround") -- ysw+<char> to add, ds+<char> to del
  use("vim-scripts/ReplaceWithRegister") -- yw to copy, grw to replace

  -- commenting with gc
  use("numToStr/Comment.nvim") -- gc+<char> (e.g., gcc is 1, gc3j is 3 down)
  
  -- file explorer
  use("nvim-tree/nvim-tree.lua") -- <space>+e toggles the file explorer

  -- icons
  use("kyazdani42/nvim-web-devicons") -- VS code style file icons

  -- statusline
  use("nvim-lualine/lualine.nvim") -- status line ui for insert, visual, command modes

  -- fuzzy finding
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- depends on telescope
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")
  
  -- managing and installing lsp servers, linters, and formatters
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp") -- enable configuring lsp dropdown
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhances lsp UX
  use("jose-elias-alvarez/typescript.nvim") -- extends typescript actions
  use("onsails/lspkind.nvim") -- add vscode icons to autocompletion window

  -- formatting and linting
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

