source $ZSH/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/history-substring-search/zsh-history-substring-search.zsh

# Keychain support
[[ -f $(which keychain 2> /dev/null) ]] && \
    eval $(keychain --nogui --eval --quiet --systemd id_rsa id_ed25519)
