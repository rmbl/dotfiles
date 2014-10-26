# Ruby
alias rake="noglob rake" # necessary to make rake work inside of zsh
alias be='bundle exec'
alias bx='bundle exec'
alias cpd='cap production deploy'
alias rs='rails s'
alias rc='rails c'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias 'bk=cd $OLDPWD'

alias ls='ls --color=auto -h'
alias ll='ls -l'
alias la='ls -la'
alias lh='ls -d .*'
alias lsd='ls -aFhlG'
alias 'dus=du -sckx * | sort -nr' #directories sorted by size

alias 'psqlstart=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start'
alias 'psqlstop=/usr/local/pgsql/bin/pg_ctl stop'

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
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

