#
# ~/.bashrc
#

export GOPATH="$HOME/.go"
export PATH="/usr/local/bin:/usr/local/opt/ruby/bin:$PATH:/usr/bin/site_perl:$HOME/.local/bin:$GOPATH/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

uname=$(uname -s)
if [ "$uname" != "Darwin" ]; then
    alias ls='ls --color=auto'
fi
alias ll='ls -l'
alias la='ls -la'
export LESSS='-R'
PS1='[\u@\h \W]\$ '

# USE VIM FFS!!
alias nano='vim'
alias vi='vim'

# Custom stuff
export EDITOR="vim"
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
if [ hash keychain 2>/dev/null ] && [ -e ~/.ssh/id_rsa ] && [ -e ~/.ssh/github_rsa ]; then
    eval $(keychain --eval --agents ssh -Q --quiet id_rsa github_rsa)
fi

function _update_ps1() {
   export PS1="$(powershell username hostname path git prompt $?)"
}

export PROMPT_COMMAND="_update_ps1"

