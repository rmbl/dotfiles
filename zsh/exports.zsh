export TERM=xterm-256color
export CLICOLOR=1
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LC_COLLATE=C

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR='nvim'

export ANDROID_HOME="/home/pgildein/Android/Sdk"

export LIBVIRT_DEFAULT_URI="qemu:///system"

if which rustc >/dev/null; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
