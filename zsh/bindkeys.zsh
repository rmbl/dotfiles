# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a  
bindkey "^E"      end-of-line                          # ctrl-e
bindkey "[B"      history-search-forward               # down arrow
bindkey "[A"      history-search-backward              # up arrow
bindkey "^D"      delete-char                          # ctrl-d
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b

if [ -f /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    # bind UP and DOWN arrow keys
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

    # bind P and N for EMACS mode
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down

    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

bindkey -v   # Default to standard vi bindings, regardless of editor string
