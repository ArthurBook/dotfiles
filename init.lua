-- Constants
local IS_EMPTY = 1

-- Bootstrap
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Global Settings
vim.o.clipboard = "unnamedplus"
vim.wo.number = true

-- Plugin Management
require('packer').startup(function()
  use 'petobens/poet-v'
  use 'psf/black'
  use 'fisadev/vim-isort'
  use 'tpope/vim-commentary'
  use 'scrooloose/nerdtree'
  use 'davidhalter/jedi-vim'
  use 'ycm-core/YouCompleteMe'
  use 'sheerun/vim-polyglot'
  use 'dense-analysis/ale'
  use 'neovim/nvim-lspconfig'
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
    autocmd VimEnter PoetvActivate
    autocmd BufWritePre *.py execute ':Black'
    autocmd BufNewFile,BufRead *.py lua SetupALEForPython()
    autocmd BufNewFile,BufRead *.py lua SetupLSPForPython()
  augroup END
  let g:vim_isort_map = '<C-i>'
  let g:vimspector_enable_mappings = 'HUMAN'
]]

function SetupPythonEnv()
  local POETRY_PATH = vim.fn.system('poetry env info -p'):gsub('%s+$', '')
  if vim.fn.empty(POETRY_PATH) == IS_EMPTY then
    local PYENV_PATH = vim.fn.system('pyenv which python'):gsub('%s+$', '')
    if vim.fn.empty(PYENV_PATH) == IS_EMPTY then
      vim.api.nvim_out_write("Warning: No local Python environment found. Falling back to system Python.\n")
    else
      vim.g.ycm_python_binary_path = PYENV_PATH
    end
  else
    vim.g.ycm_python_binary_path = POETRY_PATH
  end
end

function SetupALEForPython()
  vim.g.ale_linters = {python = {'flake8', 'pylint', 'mypy'}}
  vim.g.ale_fixers = {python = {'autopep8', 'yapf', 'black'}}
  vim.g.ale_enabled = 1
end

function SetupLSPForPython()
  local lspconfig = require('lspconfig')
  lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
  })
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
