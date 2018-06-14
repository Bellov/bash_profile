

#!/:"bin/bash

# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export PS1="___________________    | \w @ \h (\u) \n| => "
export PS2="| => "

# Git prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

eval "$(rbenv init -)"

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

function cd () { builtin cd "$@" && printf "\033]0;$(__git_ps1 '%s')\007"; }
function checkout () { git checkout "$@" && printf "\033]0;$(__git_ps1 '%s')\007"; }

# LS

export TERM=xterm-color
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
# export LSCOLORS=Exfxcxdxbxegedabagacad
export LSCOLORS=gxfxcxdxbxegedabagacad # Dark lscolor scheme
# Don't put duplicate lines in your bash history
export HISTCONTROL=ignoredups
# increase history limit (100KB or 5K entries)
export HISTFILESIZE=100000
export HISTSIZE=5000

# Define some colors first:
RED='\[\e[1;31m\]'
BOLDYELLOW='\[\e[1;33m\]'
GREEN='\[\e[0;32m\]'
BLUE='\[\e[1;34m\]'
DARKBROWN='\[\e[1;33m\]'
DARKGRAY='\[\e[1;30m\]'
CUSTOMCOLORMIX='\[\e[1;30m\]'
DARKCUSTOMCOLORMIX='\[\e[1;32m\]'
LIGHTBLUE="\[\033[1;36m\]"
PURPLE='\[\e[1;35m\]' #git branch
# EG: GREEN="\[\e[0;32m\]" 
#PURPLE='\[\e[1;35m\]'
#BLUE='\[\e[1;34m\]'
NC='\[\e[0m\]' # No Color
#PS1="\[\033[1;34;40m[\033[1;31;40m\u@\h:\w\033[1;34;40m]\033[1;37;40m $\033[0;37;0m\] "
#PS1="${CUSTOMCOLORMIX}\\u@\h: \\W]\\$ ${NC}"

export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
alias ls='ls -AFG'
alias ll='ls -hAlF'
alias l='ls -AlF'
alias sbl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias atom='open -a Atom'
alias ll='ls -FGlAhp'
alias sl='ls'
alias ks='ls'
alias LS='ls'
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

#os
alias Cd..='cd'
alias cd..='cd ..'
alias cle='clear'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

#networking
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc

#some administrative ones
alias su='sudo su'
alias chown='sudo chown'
alias path='echo -e ${PATH//:/\\n}'
trash () { command mv "$@" ~/.Trash ; } 
alias edit='subl' 

#git
alias gs='git status'
alias gp='git pull'
alias gc='git checkout'
alias gs='git status'
alias gi='git init'
alias gd='git diff'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gss='git status --short'


export PS1="\[\033[38m\]\u\[\033[32m\] \w \[\033[31m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.split(%r{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\[\033[37m\]$\[\033[00m\] "
# export PS1="\[\033[38m\]\u\[\033[32m\] \w \[\033[31m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.split(%r{\n}).grep(/^\*/).first $"
git config --global color.ui true
git config --global format.pretty oneline
git config --global core.autocrl input
git config --global core.fileMode true
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias push='git pull origin master && git push origin master'
alias pull='git pull origin master'
alias clone='git clone $1'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# ls
if [[ ${OSTYPE} = darwin* || ${OSTYPE} = freebsd* ]]; then
  # freebsd & osx both have color support in `ls'
  export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
  alias ls='ls -AFG'
elif [[ ${OSTYPE} = openbsd* ]]; then
  # on openbsd `colorls' is a different tool
  if type -p colorls >/dev/null; then
    export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
    alias ls='colorls -AFG'
  elsu
    alias ls='ls -AF'
  fi
elif [[ ${OSTYPE} = netbsd* ]]; then
  # on netbsd `colorls' is generally crippled, but still better than nothing
  if type -p colorls >/dev/null; then
    export LSCOLORS='6x5x2x3x1x464301060203'
    alias ls='colorls -AFG'
  else
    alias ls='ls -AF'
  fi
else
  # assume we have gnu coreutils
  alias ls='ls -AF --color=auto'
fi

#!/:"bin/bash

# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

