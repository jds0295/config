alias code="open -a Visual\ Studio\ Code"
alias coffee="caffeinate"
alias d="docker"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias finder="open `pwd`"
alias f="pay-respects"
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias gcne="git commit --amend --no-edit"
alias gp="git push"
alias gpf="git push -f"
alias hg="history | grep"
alias k="kubectl"
alias k19="kubectl19"
alias kgc="kubectl config get-contexts"
alias ll="ls -al"
alias lz="lazygit"
alias n="nvim"
alias nz="nvim ~/.zshrc"
alias nzz="nvim ~/.config/zshrc/"
alias oa="okta-aws"
alias p3="python3"
#alias pip="pip3"
#alias python="python3"
alias p="podman"
alias pcu="podman-compose up -d"
alias pcd="podman-compose down"
alias pcr="podman-compose down; podman-compose up -d"
alias sz="source ~/.zshrc"
alias sed="gsed"
alias shad="ssh-add ~/.ssh/twgbitbucket"
alias t="tmux"
alias ta="tmux attach"
alias tf="terraform"
alias xx="exit"
# alias z="zoxide"
alias :q="exit"

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

b64() {
 echo $1 | base64 -d
}

retag() {
	git tag --delete $1 && git tag $1 && git push --delete origin $1 && git push origin $1
}
