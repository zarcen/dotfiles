# Function to check and install a command
# Arguments:
#   1. Command to check existence (e.g., atuin)
#   2. Installation command to use if the command does not exist
check_and_install() {
    local command_to_check="$1"
    local install_command="$2"

    # Check if the command exists
    if ! command -v "$command_to_check" &>/dev/null; then
        echo "$command_to_check is not installed. Installing..."

        # Run the installation command
        eval "$install_command"

        # Check if the installation was successful
        if command -v "$command_to_check" &>/dev/null; then
            echo "$command_to_check installed successfully."
        else
            echo "Failed to install $command_to_check. Please check the installation script or your network connection."
            exit 1
        fi
    fi
}

function init() {
  check_and_install "starship" "curl -sS https://starship.rs/install.sh | sh"
  # Initialize starship
  #eval "$(starship init zsh)"

  # Which plugins would you like to load?
  # Standard plugins can be found in $ZSH/plugins/
  # Custom plugins may be added to $ZSH_CUSTOM/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  plugins=(git kubectl kube-ps1)

  # Set name of the theme to load --- if set to "random", it will
  # load a random theme each time oh-my-zsh is loaded, in which case,
  # to know which specific one was loaded, run: echo $RANDOM_THEME
  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
  export ZSH_THEME="simple"

  # Path to your oh-my-zsh installation.
  export ZSH="$HOME/.oh-my-zsh"
  source $ZSH/oh-my-zsh.sh

  # Download Znap, if it's not there yet.
  [[ -r ~/.local/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
      https://github.com/marlonrichert/zsh-snap.git ~/.local/znap
  # declare directory znap manages
  zstyle ':znap:*' repos-dir ~/.znap
  source ~/.local/znap/znap.zsh # Start Znap

  # atuin - magical shell history (https://github.com/atuinsh/atuin)
  check_and_install "$HOME/.atuin/bin/atuin" "curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh"
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
  # import the history for your current shell
  atuin import auto
}

function install_znap_plugins() {
  # https://github.com/marlonrichert/zsh-autocomplete - 🤖 Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion.
  #znap source marlonrichert/zsh-autocomplete
  # https://github.com/Tarrasch/zsh-bd - Jump back to a specific directory, without doing `cd ../../..`
  #znap source Tarrasch/zsh-bd
  # https://github.com/wfxr/forgit - 💤 A utility tool powered by fzf for using git interactively.
  #znap source wfxr/forgit
  # https://github.com/zsh-users/zsh-autosuggestions - Fish-like autosuggestions for zsh
  znap source zsh-users/zsh-autosuggestions
  # https://github.com/zsh-users/zsh-completions - Additional completion definitions for Zsh.
  znap source zsh-users/zsh-completions
  # https://github.com/zsh-users/zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh.
  znap source zsh-users/zsh-syntax-highlighting
  # https://github.com/aureliojargas/clitest - Command Line Tester tool
  znap install aureliojargas/clitest 
}

function aliases() {
  # aliases
  alias c="clusterctl"
}

function export_opts() {
  # local bin
  export PATH="$HOME/bin:$PATH"

  # Gitlab PAT
  GITLAB_TOKEN="abcxyz"
  export GITLAB_ACCESS_TOKEN=$GITLAB_TOKEN

  # Github PAT
  export GITHUB_PAT="ghp_123xyz"

  # Add krew export
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

  # Default AWS
  export AWS_DEFAULT_PROFILE=AWSPowerUserAccess-1234567
  export AWS_PAGER=""

  # GO
  export GOPRIVATE="github.com/zarcen/*"
  export GONOSUMDB="github.com/zarcen/*"
  export PATH="$(go env GOPATH)/bin:$PATH"

  # Docker
  export PATH="$PATH:$HOME/.docker/bin"

  # Colima
  export COLIMA_HOME="$HOME/.colima"
  export DOCKER_HOST="unix://${COLIMA_HOME}/default/docker.sock" 
  #export DOCKER_HOST="unix://${COLIMA_HOME}/amd64/docker.sock" 

  # Prefer GNU bins (e.g. mac has BSD grep)
  PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

  # PS1
  export PROMPT='$(kube_ps1)'$'\n'$PROMPT

  # KUBECONFIG
  KUBECONFIG=~$(gmktemp --suffix=-kubeconfig)
  export KUBECONFIG
}

function main() {
  init
  install_znap_plugins
  aliases
  export_opts
}

main

