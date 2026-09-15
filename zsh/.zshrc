# Minimal interactive Zsh setup — managed with GNU Stow.

# User-installed CLIs (including Codex) live here.  The installer updated
# ~/.profile, which Zsh does not read; tmux starts the user's Zsh by default.
export PATH="$HOME/.local/bin:$PATH"

# Recover a *non-tmux* terminal left in xterm mouse-reporting mode by a
# disconnected full-screen program. In tmux, mouse state belongs to tmux.
_disable_leaked_mouse_reporting() {
  [[ -z ${TMUX-} && -t 1 ]] || return
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1005l\e[?1006l\e[?1015l'
}
if [[ -o interactive ]]; then
  _disable_leaked_mouse_reporting
  precmd_functions+=(_disable_leaked_mouse_reporting)
fi

# Fast, case-insensitive Tab completion.
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Shared, de-duplicated command history.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS

# Compact, home-relative path plus $ (or # for root), for example ~/code/app.
PROMPT='%~ %# '

# Modern directory listings. Keep the familiar ls, ll, and la commands.
if (( $+commands[eza] )); then
  # High-contrast eza palette: avoids the faint grey metadata in its defaults.
  export EZA_COLORS='di=1;94:ex=1;92:ln=1;96:da=97:hd=1;97:uu=1;97:gu=1;97:sn=1;97:sb=1;97:ur=92:uw=91:ux=92:gr=93:gw=91:gx=92:tr=93:tw=91:tx=92'
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza --long --header --git --group-directories-first --icons=auto'
  alias la='eza --long --all --header --git --group-directories-first --icons=auto'
fi

# Smart directory navigation. `cd` keeps its normal Tab completion; use `z`
# to jump to a frequently used directory and `zi` to choose one with fzf.
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Autosuggestions from the Ubuntu package.
if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Modified cursor keys, including the sequences sent through tmux.
for keymap in emacs viins; do
  bindkey -M "$keymap" '^[[1;5C' forward-word
  bindkey -M "$keymap" '^[[1;5D' backward-word
  bindkey -M "$keymap" '^[[1;5A' up-line-or-history
  bindkey -M "$keymap" '^[[1;5B' down-line-or-history
  bindkey -M "$keymap" '^[[5C' forward-word
  bindkey -M "$keymap" '^[[5D' backward-word
  bindkey -M "$keymap" '^[[1;3C' forward-word
  bindkey -M "$keymap" '^[[1;3D' backward-word
  bindkey -M "$keymap" '^[[3C' forward-word
  bindkey -M "$keymap" '^[[3D' backward-word
done

# Some remote terminal connections leak this Secondary Device Attributes reply
# (ESC [ > 0 ; 10 ; 1 c) into Zsh after attaching. It is not user input, so
# discard it when it reaches the line editor. OSC 52 clipboard passthrough is
# unaffected.
_ignore_terminal_device_attributes() { }
zle -N _ignore_terminal_device_attributes
for keymap in emacs viins; do
  bindkey -M "$keymap" '^[[>0;10;1c' _ignore_terminal_device_attributes
done

# Syntax highlighting must be sourced last.
if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
