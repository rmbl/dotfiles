source $ZSH/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/history-substring-search/zsh-history-substring-search.zsh

# Keychain support
[[ -f $(which keychain 2> /dev/null) ]] && \
    keychain --nogui -Q -q id_rsa github_rsa
