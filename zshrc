# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="zarcen"

# screen prompt
# this will enable the hardstatus show the dynamic command title in screen
export PROMPT_COMMAND='printf "\033k\033\134"'
#

# encoding and language
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails ruby)

source $ZSH/oh-my-zsh.sh

### User configuration

# turn off auto-correct for the annoying stuff
alias cp='nocorrect cp '
alias mv='nocorrect mv '
alias mkdir='nocorrect mkdir '

# Useful aliases
alias zshconfig='vim ~/.zshrc'
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cls="clear"
# mv,cp,rm checking
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias ls='ls -G' # colorize
#alias l="ls -l" # list with more info
alias grep="grep --color=auto"
alias f='find . | grep'
# alias Preview to open pdf,jpeg,.... files
alias prev='open -a Preview'

# PATH
# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
# rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# homebrew
export PATH="$PATH:/usr/local/sbin" # Add homebrew's sbin


# EDITOR
# let latest macvim (from homebrew)
#     replace the system default vim
alias vi='mvim -v'
alias vim='mvim -v'
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  #export EDITOR="emacs"
else
  export EDITOR='vim'
  #export EDITOR='mvim' # use MacVim
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


### functions (for MacOSX)
# toggle iTerm Dock icon
# add this to your .bash_profile or .zshrc
function toggleiTerm() {
pb='/usr/libexec/PlistBuddy'
iTerm='/Applications/iTerm.app/Contents/Info.plist'
echo "Do you wish to hide iTerm in Dock?"
select ync in "Hide" "Show" "Cancel"; do
  case $ync in
    'Hide' )
      $pb -c "Add :LSUIElement bool true" $iTerm
      echo "relaunch iTerm to take effectives"
      break
      ;;
    'Show' )
      $pb -c "Delete :LSUIElement" $iTerm
      echo "run killall 'iTerm' to exit, and then relaunch it"
      break
      ;;
    'Cancel' )
      break
      ;;
  esac
done
}
##
