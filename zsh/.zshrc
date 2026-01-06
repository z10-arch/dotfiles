# ==================================================
# Zsh – clean, fast, no framework
# ==================================================

# ----------------------------
# Antidote (plugin manager)
# ----------------------------
if [ -f "$HOME/.antidote/antidote.zsh" ]; then
  source "$HOME/.antidote/antidote.zsh"
  antidote load
fi

# ----------------------------
# Completion system
# ----------------------------
autoload -Uz compinit
compinit -d "$HOME/.zcompdump"

# ----------------------------
# Starship prompt
# ----------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ----------------------------
# History configuration
# ----------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# ----------------------------
# Keybindings
# ----------------------------
bindkey -e

# ----------------------------
# Environment variables
# ----------------------------
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ----------------------------
# PATH (safe default)
# ----------------------------
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# ----------------------------
# Zsh behavior
# ----------------------------
setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB
setopt PROMPT_SUBST

# ----------------------------
# Aliases (modern tools)
# ----------------------------
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -l --icons --git"
  alias la="eza -la --icons"
else
  alias ll="ls -lh"
  alias la="ls -la"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="batcat"
fi

if command -v nvim >/dev/null 2>&1; then
  alias vim="nvim"
fi

# ----------------------------
# Safety for root
# ----------------------------
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# ----------------------------
# DevOps helpers
# ----------------------------
alias k="kubectl"
alias tf="terraform"
alias tg="terragrunt"
alias d="docker"
alias dc="docker compose"

# ----------------------------
# FZF integration (optional)
# ----------------------------
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
fi

# ----------------------------
# End
# ----------------------------

# Go environment (added by Rovo Dev)
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Go toolchain path (added by Rovo Dev)
export PATH="/usr/local/go/bin:$PATH"
