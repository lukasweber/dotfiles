export GPG_TTY=$(tty)

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias ld='lazydocker'
alias lg='lazygit'
