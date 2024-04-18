# Exports
export ZSH_DIR="$HOME/.config/zsh"
export ZSH="$ZSH_DIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Enable Custom Variables
ZSH_THEME="dragosmara"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"


# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# Sourcing
source $ZSH/oh-my-zsh.sh
source $ZSH_DIR/functions/nvims.zsh

# Aliases
alias ls='lsd'
alias clear='clear && printf "\e[3J"'

# Exports
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PYTHONPATH="$(python3 -m site --user-site):$PYTHONPATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"


# Created by `pipx` on 2024-04-02 09:11:42
export PATH="$PATH:/Users/duckyshine04/.local/bin"
