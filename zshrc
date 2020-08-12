export ZSH=$HOME/.zsh

source $ZSH/setopt.zsh

autoload -U colors && colors
# Default colors:
# Cyan for users, red for root, magenta for system users
local _time="%{$fg[yellow]%}[%*]"
local _path="%B%{$fg[green]%}%(8~|...|)%7~"

if [[ $EUID -lt 1000 ]]; then
	# red for root, magenta for system users
	_usercol="%(!.%{$fg[red]%}.%{$fg[magenta]%})"
else
	_usercol="$fg[cyan]"
fi
local _user="%{$_usercol%}%n@%M"
local _prompt="${(r:$SHLVL*2::%#:)}"

PROMPT="╭─ $_time $_user $_path
%{$fg[white]%}%b╰─%B$_prompt%b%f%k "

RPROMPT='${vcs_info_msg_0_}' # git branch
if [[ ! -z "$SSH_CLIENT" ]]; then
	RPROMPT="$RPROMPT " # ssh icon
fi

PROMPT_EOL_MARK=""

# add ~/bin to $PATH
path=(~/.bin bin $path)

if which yarn >/dev/null 2>&1; then
    path=(~/.yarn/bin $path)
fi

if which ruby >/dev/null 2>&1 && which gem >/dev/null 2>&1; then
    path=($(ruby -r rubygems -e 'puts Gem.user_dir')/bin $path)
fi

# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init {
		printf "%s" ${terminfo[smkx]}
	}
	function zle-line-finish {
		printf "%s" ${terminfo[rmkx]}
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

# typing ... expands to ../.., .... to ../../.., etc.
rationalise-dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
bindkey -M isearch . self-insert # history search fix

# Check if $LANG is badly set as it causes issues
if [[ $LANG == "C"  || $LANG == "" ]]; then
	>&2 echo "$fg[red]The \$LANG variable is not set. This can cause a lot of problems.$reset_color"
fi

source $ZSH/plugins.zsh
source $ZSH/aliases.zsh
source $ZSH/exports.zsh
source $ZSH/completions.zsh
source $ZSH/functions.zsh
source $ZSH/bindkeys.zsh
source $ZSH/history.zsh
source $ZSH/zsh_hooks.zsh
source $ZSH/vcs.zsh

source $ZSH/nvm.sh
#source $ZSH/rvm.sh

# Load system specific stuff from untracked config
if [[ -f $ZSH/user.zsh ]]; then
	source $ZSH/user.zsh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
