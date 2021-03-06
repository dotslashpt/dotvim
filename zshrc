export TERM="xterm-256color"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=8

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
plugins=(aws bower bundler colored-man-pages colorize common-aliases docker docker-compose docker-machine gem git git-extras gitignore git-flow gcloud go grunt gulp heroku man mvn node npm nvm pip postgres sbt scala sudo themes ubuntu zsh-navigation-tools zsh_reload rvm rails rake rbenv ruby vagrant emoji terraform)

# Powerline customization
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
POWERLEVEL9K_HOME_ICON='\uF0AE '
POWERLEVEL9K_NODE_ICON='\u2B22 '
POWERLEVEL9K_NETWORK_ICON='\uF1EB '
POWERLEVEL9K_RAM_ICON='\uF0E4 '
POWERLEVEL9K_HOME_SUB_ICON='\uF07C '
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX='\uf0da'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon battery dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status nvm ip load ram context)

POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_BATTERY_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/.bin/:$HOME/.ssh/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.yarn/bin"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/"
alias glo="git log --oneline --date-order --date=iso --graph --full-history --all --pretty=format:'%x08%x09%C(red)%h %C(cyan)%ad%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08 %C(bold blue)%aN%C(reset)%C(bold yellow)%d %C(reset)%s'"
alias weather="curl -4 http://wttr.in/bogota"
alias lc="colorls -sd -r -a"
alias tcom='truffle compile'
alias tcon='truffle console'
alias tmig='truffle migrate'
alias tmie='truffle migrate --reset --compile-all && truffle console'
alias dcomp='docker-compose'
alias xclip='xclip -sel clip'
alias fuck='sudo $(fc -ln -1)'

PS1='[\u@\h \W$(__docker_machine_ps1)]\$ '

mkcd(){
  mkdir -p $1
  cd $1
}

slacky () {
  slack-term --config ~/.slacky/$1.json
}

tellme(){
  dict $1 | less
}
mycnc() {
  mysql --defaults-group-suffix=$1
}

myRecordingVoiceAndAudio(){
  pactl load-module module-null-sink sink_name=duplex_out
  pactl load-module module-null-sink sink_name=game_out
  pactl load-module module-loopback source=game_out.monitor
  pactl load-module module-loopback source=game_out.monitor sink=duplex_out
  pactl load-module module-loopback sink=duplex_out
}

myUnloadRecordingVoiceAndAudio(){
  pactl unload-module module-loopback
  pactl unload-module module-null-sink
}

function proxy_on() {
  export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

  if (( $# > 0 )); then
    valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\)\{4\}:\([0-9]\+\)/&/p')
    if [[ $valid != $@ ]]; then
      >&2 echo "Invalid address"
      return 1
    fi

    export http_proxy="http://$1/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    echo "Proxy environment variable set."
    return 0
  fi

  echo -n "username: "; read username
  pre=""
  if [[ $username != "" ]]; then
    echo -n "password: \n"
    read -s password
    pre="$username:$password@"
  fi

  echo -n "server: "; read server
  echo -n "port: "; read port
  export http_proxy="http://$pre$server:$port/"
  export https_proxy="https://$pre$server:$port/"
  export ftp_proxy=$http_proxy
  export rsync_proxy=$http_proxy
  export socks_proxy=$http_proxy
  export gopher_proxy=$http_proxy
  export http_proxy=$http_proxy
  export no_proxy=$http_proxy
}

function proxy_off(){
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset rsync_proxy
  echo -e "Proxy environment variable removed."
}

(fortune; echo "\nImportant dates:\n"; calendar -l 0) | cowthink -f eyes
