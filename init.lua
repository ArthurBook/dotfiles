-- Bootstrap
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Global Settings
vim.opt.number = true
vim.cmd 'syntax enable'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.clipboard = "unnamedplus"

-- Plugin Management
require('packer').startup(function()
  use 'davidhalter/jedi-vim'
  use 'psf/black'
  use 'ycm-core/YouCompleteMe'
  use 'scrooloose/nerdtree'
  use 'sheerun/vim-polyglot'
  use {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_linters = {python = {'flake8', 'pylint', 'mypy'}}
      vim.g.ale_fixers = {python = {'autopep8', 'yapf', 'black'}}
      vim.api.nvim_set_keymap('n', '<C-l>', ':ALEFix<CR>', {noremap = true, silent = true})
    end
  }
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup({
        cmd = { "pyright-langserver", "--stdio" },
      })
    end
  }
  use 'tpope/vim-fugitive'
  use 'puremourning/vimspector'
  use 'vim-airline/vim-airline'
  use {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end
  }
end)

-- Language-Specific Settings
vim.cmd [[
  augroup MyPythonSettings
    autocmd!
    autocmd BufNewFile,BufRead *.py lua SetupPythonEnv()
    autocmd BufNewFile,BufRead *.py lua SetupPythonVimSettings()
    autocmd BufWritePre *.py execute ':Black'
  augroup END
]]

function SetupPythonEnv()
  vim.g.python3_host_prog = vim.fn.system('pyenv which python'):gsub('%s+$', '')
  vim.g.ycm_python_binary_path = vim.fn.system('poetry env info -p'):gsub('%s+$', '')
end

function SetupPythonVimSettings()
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.textwidth = 79
  vim.opt.expandtab = true
  vim.opt.autoindent = true
  vim.cmd 'set fileformat=unix'
end

-- Keybindings
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {noremap = true, silent = true})

