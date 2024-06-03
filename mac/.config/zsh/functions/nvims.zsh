# alias nvim="NVIM_APPNAME=nvim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-gru="NVIM_APPNAME=GruVim nvim"

function nvims() {
	items=("default", "NvChad", "GruVim")
	config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=50% --layout=reverse --border --exit-0)
	if [[ -z $config ]]; then
		echo "Nothing selected"
		return 0
	elif [[ $config == "default" ]]; then
		config=""
	fi
	NVIM_APPNAME=$config nvim $@
}

function kitty-reload() {
	kill -SIGUSR1 $KITTY_PID
}
