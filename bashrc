#
# ~/.bashrc
#

export PATH="$PATH:/usr/bin/site_perl:/home/rmbl/.local/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
export LESSS='-R'
PS1='[\u@\h \W]\$ '

# USE VIM FFS!!
alias nano='vim'

# Custom stuff
set -o vi
export EDITOR="vim"
export DISPLAY=:5

export TERM=xterm-256color

# Options
shopt -s cdspell
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

export HISTCONTROL=ignoredups
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"

# Start ssh-agent with all keys
eval $(keychain --eval --agents ssh -Q --quiet id_rsa github_rsa)

function _update_ps1() {
   export PS1="$(~/bin/powerline-shell/powerline-shell.py --colorize-hostname $?)"
}

export PROMPT_COMMAND="_update_ps1"

