#colors
autoload -U colors && colors
PS1="%B%{$fg[cyan]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%&-> %{$fg[cyan]%}]%{$reset_color%}$%b "

#history
HISTSIZE=15000 SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Ctrl+arrow = word skip
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word


# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
