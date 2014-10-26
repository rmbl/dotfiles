p() { cd ~/Dropbox/Workspace/$1; }
compctl -W ~/Dropbox/Workspace -/ p

# -------------------------------------------------------------------
# compressed file expander 
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
# -------------------------------------------------------------------
ex() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.tar.xz) tar xvJf $1;;
            *.tar.lzma) tar --lzma xvf $1;;
            *.bz2) bunzip $1;;
            *.rar) unrar $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7z x $1;;
            *.dmg) hdiutul mount $1;; # mount OS X disk images
            *) echo "'$1' cannot be extracted via >ex<";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
# search for running processes
# -------------------------------------------------------------------
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

# -------------------------------------------------------------------
# display a neatly formatted path
# -------------------------------------------------------------------
path() {
    echo $PATH | tr ":" "\n" | \
        awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
        sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
        sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
        sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
        sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
        print }"
}

# -------------------------------------------------------------------
# (s)ave or (i)nsert a directory.
# -------------------------------------------------------------------
s() { pwd > ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }

function zsh_recompile {
    autoload -U zrecompile
    rm -f ~/.zsh/*.zwc
    [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
    [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old
    for f in ~/.zsh/**/*.zsh; do
        [[ -f $f ]] && zrecompile -p $f
        [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
    done
    [[ -f ~/.zcompdump ]] && zrecompile -p ~/.zcompdump
    [[ -f ~/.zcompdump.zwc.old ]] && rm -f ~/.zcompdump.zwc.old
    source ~/.zshrc
}

function ss {
    if [ -e script/server ]; then
        script/server $@
    else
        script/rails server $@
    fi
}
function sc {
    if [ -e script/rails ]; then
        script/rails console $@
    else
        script/console $@
    fi
}

magic-enter () {
    if [[ -z $BUFFER ]]; then
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            echo -ne '\n'
            git status
        fi
        zle accept-line
    else
        zle accept-line
    fi
}
zle -N magic-enter
bindkey "^M" magic-enter
