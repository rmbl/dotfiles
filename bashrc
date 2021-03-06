#
# ~/.bashrc
#

export GOPATH="$HOME/.go"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/opt/ruby/bin:$PATH:/usr/bin/site_perl:$HOME/.local/bin:$GOPATH/bin:bin:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -h'
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
if hash keychain 2>/dev/null && [ -f ~/.ssh/id_rsa ] && [ -f ~/.ssh/github_rsa ]; then
    eval $(keychain --eval --agents ssh -Q --quiet id_rsa github_rsa)
fi

# Load Bash Completion
if hash brew 2>/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
elif [ -r /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

function _update_ps1() {
   export PS1="$(powershell username hostname path git prompt $?)"
}

export PROMPT_COMMAND="_update_ps1"


# added by travis gem
[ -f /Users/rmbl/.travis/travis.sh ] && source /Users/rmbl/.travis/travis.sh
