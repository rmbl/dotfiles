export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/bin/site_perl:/Users/rmbl/.local/bin:/Users/rmbl/.go/bin:bin:/Users/rmbl/.rvm/bin"

export TERM=xterm-256color
export CLICOLOR=1

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR='vim'

export LC_COLLATE=C

