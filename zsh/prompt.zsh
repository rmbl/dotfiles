autoload -U colors && colors # Enable colors in prompt

PROMPT='
╭─ %(!.${PR_BOLD_RED}.${PR_BOLD_GREEN})%n@%m%{$reset_color%} ${PR_BOLD_BLUE}%~%{$reset_color%}
%4{╰─%B%#%b %}'
RPS1="${%?}"

export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "
