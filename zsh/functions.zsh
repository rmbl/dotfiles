p() { cd ~/Dropbox/Workspace/$1; }
compctl -W ~/Dropbox/Workspace -/ p

# Start/Stop DO vms using tugboat cli
vm() {
    local vm_name='vm'
    if [[ -z "$1" ]] ; then
        echo "Usage: vm (start|stop|ssh|status)"
    else
        image=$(tugboat images | grep ${vm_name} | egrep -o '\d+')
        case $1 in
            start)
                echo 'Starting VM...'
                if [ -z ${image} ]; then
                    tugboat create ${vm_name} -q
                else
                    tugboat create ${vm_name} -i ${image} -q
                fi
                tugboat wait ${vm_name} -q
                ;;
            stop)
                echo 'Stopping VM...'
                tugboat halt ${vm_name} -q
                tugboat wait ${vm_name} --state off -q

                if [ ! -z ${image} ]; then
                    echo 'Destroying old snapshot...'
                    tugboat destroy_image -i ${image} -c -q
                fi

                echo 'Creating Snapshot...'
                tugboat snapshot ${vm_name} ${vm_name} -q
                tugboat wait ${vm_name} -q

                echo 'Destroying VM...'
                tugboat destroy ${vm_name} -q -c
                ;;
            ssh)
                echo 'SSHing to VM'
                shift
                tugboat ssh -q ${vm_name} $@
                ;;
            status)
                state=$(tugboat droplets | egrep "^${vm_name}")
                if [ -z $state ]; then
                    echo "VM is currently ${BOLD_RED}stopped${reset_color}."
                else
                    echo "VM is currently ${BOLD_GREEN}running${reset_color}."
                fi
                ;;
            ip)
                ip=$(tugboat droplets | grep ${vm_name} | egrep -o "\d+\.\d+\.\d+\.\d+")
                echo $ip
                ;;
        esac
    fi
}

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

# make a backup of a file
# https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
bk() {
	cp -a "$1" "${1}_$(date --iso-8601=seconds)"
}

# display a list of supported colors
function lscolors {
	((cols = $COLUMNS - 4))
	s=$(printf %${cols}s)
	for i in {000..$(tput colors)}; do
		echo -e $i $(tput setaf $i; tput setab $i)${s// /=}$(tput op);
	done
}

# print a separator banner, as wide as the terminal
function hr {
	print ${(l:COLUMNS::=:)}
}

# urlencode text
function urlencode {
	print "${${(j: :)@}//(#b)(?)/%$[[##16]##${match[1]}]}"
}

# get public ip
function myip {
	local api
	case "$1" in
		"-4")
			api="http://v4.ipv6-test.com/api/myip.php"
			;;
		"-6")
			api="http://v6.ipv6-test.com/api/myip.php"
			;;
		*)
			api="http://ipv6-test.com/api/myip.php"
			;;
	esac
	curl -s "$api"
	echo # Newline.
}

# Create short urls via http://goo.gl using curl(1).
# Contributed back to grml zshrc
# API reference: https://code.google.com/apis/urlshortener/
function zurl {
	if [[ -z $1 ]]; then
		print "USAGE: $0 <URL>"
		return 1
	fi

	local url=$1
	local api="https://www.googleapis.com/urlshortener/v1/url"
	local data

	# Prepend "http://" to given URL where necessary for later output.
	if [[ $url != http(s|)://* ]]; then
		url="http://$url"
	fi
	local json="{\"longUrl\": \"$url\"}"

	data=$(curl --silent -H "Content-Type: application/json" -d $json $api)
	# Match against a regex and print it
	if [[ $data =~ '"id": "(http://goo.gl/[[:alnum:]]+)"' ]]; then
		print $match
	fi
}


