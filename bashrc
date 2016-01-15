##### The file is sourced by .bash_profile #####
## Mac OS X's Terminal.app actually runs a login shell rather
## than a non-login shell by default for each new terminal window,
## calling .bash_profile instead of .bashrc.

# cls setting
alias cls='clear'
#
# mv,cp,rm checking
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ls='ls -G' # colorize
alias grep='grep --color=auto'
#
# list with more info
alias ll='ls -l'
#
# alias Preview to open pdf,jpeg,.... files
alias prev='open -a Preview'
#
# Intel kontron connection
#alias ssh_kontron='ssh root@172.32.255.1'
alias ssh_kontron='ssh root@140.112.49.152'
alias ssh_mini='ssh labuser@140.112.49.154'
# alias the R217 ssh connection #alias r217='ssh b96075@linux12.csie.ntu.edu.tw'
#

# my PS1 setting
# default
#export PS1="\[\e[36;1m\]\u @ \h \[\e[33;1m\]\w \[\e[31;1m\]\\$ \[\e[0m\]"
# for workstation. e.g. zarcen@server12:<dir> $ ...
#export PS1="\[\e[32;1m\]\u\[\e[0m\]@\[\e[36;1m\]\h\[\e[0m\]:\[\e[33;1m\]\w\[\e[31;1m\]$ \[\e[0m\]"
#  
export PS1="\[\e[31;1m\]> \[\e[32;1m\]\u\[\e[0m\]: \[\e[33;1m\]\w\[\e[31;1m\] $ \[\e[0m\]"
#

# screen prompt
# this will enable the hardstatus show the dynamic command title in screen
export PROMPT_COMMAND='printf "\033k\033\134"'
#

# default editor as vim
export EDITOR="vim"
#####
# replace the system default /usr/bin/vim with the latest MacVim version
# so now `which vim` is '/usr/local/bin/vim', which is the latest MacVim version
# and if prefer the gui version, use `mvim`(/usr/local/bin/mvim)
# currently, the version is 7.4(stable). it can be checked by `mvim --version`
# here is the info: 
### 7.4 (2013 Aug 10, compiled Aug 10 2013 18:40:52)
### MacOS X (unix) version
### Compiled by Douglas Drumond <douglas@eee19.com>
#####
#alias vim='mvim -v'

# default editor as emacs
#export EDITOR="emacs"

# Load RVM into a shell session *as a function*
# use RVM to control Ruby version, if want to use 
#     the native Ruby version compiled in System,
#     comment the following line, then it use the
#     `/usr/bin/ruby` instead. Check that by `which ruby`
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

# git auto-completion
source /usr/local/etc/bash_completion.d/git-completion.bash

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

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
