# Ruby
alias rake="noglob rake" # necessary to make rake work inside of zsh
alias spring="nocorrect spring"
alias be='bundle exec'
alias bx='bundle exec'
alias cpd='cap production deploy'
alias rs='rails s'
alias rc='rails c'

alias 'bk=cd $OLDPWD'

alias ls='ls --color=auto -h'
alias sl="ls"
alias l="ls -CF"
alias ll='ls -l'
alias la='ls -la'
alias lh='ls -d .*'
alias lsd='ls -aFhlG'
alias lash="ls -lAsh"
alias 'dus=du -sckx * | sort -nr' #directories sorted by size

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'

# Color aliases
if command -V dircolors >/dev/null 2>&1; then
	eval "$(dircolors -b)"
	# Only alias ls colors if dircolors is installed
	alias ls="ls -F --color=auto"
	alias dir="dir --color=auto"
	alias vdir="vdir --color=auto"
fi

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias dmesg="dmesg --color=auto"
# make less accept color codes and re-output them
alias less="less -R"

# Make unified diff syntax the default
alias diff="diff -u"

# json prettify
alias json="python -m json.tool"

# octal+text permissions for files
alias perms="stat -c '%A %a %n'"

# Run commands in the web container using docker-compose
alias drw="docker-compose run -e PHP_IDE_CONFIG=serverName=0.0.0.0 web"
alias drwp="docker-compose run web php -d xdebug.remote_enable=0 -d xdebug.profiler_enable=0 -d xdebug.default_enable=0"

# Switch keyboard layout
alias setus="setxkbmap -layout us -variant altgr-intl -option nodeadkeys"
alias setde="setxkbmap de"
