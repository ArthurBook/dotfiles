# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/usr/local/bin:$PATH"

# bob (nvim)
export PATH="~/.local/share/bob/nvim-bin:$PATH" 

# sphinx
export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"

# mojo
export MODULAR_HOME="/Users/arthur/.modular"
export PATH="~/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# brew
export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_PREFIX=$(brew --prefix)
