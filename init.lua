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
  use 'sheerun/vim-polyglot'
  use 'scrooloose/nerdtree'
  use 'dense-analysis/ale'
  use 'neovim/nvim-lspconfig'
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

-- Defaults
vim.cmd [[
  augroup NerdTreeAutoCommands
    autocmd!
    autocmd VimEnter * NERDTree | wincmd w
  augroup END

  function! ToggleNERDTreeFocus()
    if exists("t:NERDTreeBufName")
      if bufname('%') == t:NERDTreeBufName
        wincmd w
      else
        NERDTreeFocus
      endif
    else
      NERDTree
    endif
  endfunction

  nnoremap <silent> <C-n> :call ToggleNERDTreeFocus()<CR>
  nnoremap <silent> <C-S-n> :NERDTreeToggle<CR>
]]

-- Language-Specific Settings
vim.cmd [[
  augroup MyPythonSettings
    autocmd!
    autocmd BufNewFile,BufRead *.py lua SetupPythonEnv()
    autocmd BufNewFile,BufRead *.py lua SetupPythonVimSettings()
    autocmd BufWritePre *.py execute ':Black'
    autocmd BufNewFile,BufRead *.py lua SetupALEForPython()
    autocmd BufNewFile,BufRead *.py lua SetupLSPForPython()
  augroup END
]]

function SetupPythonEnv()
  local pyenv_path = vim.fn.system('pyenv which python'):gsub('%s+$', '')
  local poetry_path = vim.fn.system('poetry env info -p'):gsub('%s+$', '')
  
  -- Use pyenv for python3_host_prog
  vim.g.python3_host_prog = pyenv_path
  
  -- Check if poetry exists, otherwise fallback to pyenv or system python
  if vim.fn.empty(poetry_path) == 1 then
    vim.g.ycm_python_binary_path = vim.fn.system('pyenv which python'):gsub('%s+$', '')
  else
    vim.g.ycm_python_binary_path = poetry_path
  end
end

function SetupLSPForPython()
  local lspconfig = require('lspconfig')
  lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
  })
end

function SetupALEForPython()
  vim.g.ale_linters = {python = {'flake8', 'pylint', 'mypy'}}
  vim.g.ale_fixers = {python = {'autopep8', 'yapf', 'black'}}
  vim.g.ale_enabled = 1
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
