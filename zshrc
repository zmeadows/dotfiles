export ZSH=~/.oh-my-zsh
ZSH_THEME="wezm"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

setopt menu_complete
bindkey -M menuselect '^M' .accept-line

function chpwd() {
    emulate -L zsh
    ls
}

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY


###########
# MACBOOK #
###########

if [[ $HOSTNAME == *"macbook"* ]]; then

###########
# TITAN #
###########

elif [[ $HOSTNAME == *"titan"* ]]; then
    export CERN_USER=zmeadows
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'

    export TERM=screen-256color
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"

    PATH=/home/zmeadows/local/bin:$PATH
    PATH=$PATH:/home/zmeadows/scripts
    PATH=$PATH:/home/zmeadows/.autojump/bin
    PATH=$PATH:$HOME/local/neovim/bin

    if [ "$PYTHONPATH" = "" ]
    then
        export PYTHONPATH=/home/zmeadows/ana/lib/python:/home/zmeadows/local/lib/python
    else
        export PYTHONPATH=$PYTHONPATH:/home/zmeadows/ana/lib/python:/home/zmeadows/local/lib/python
    fi

    setupATLAS
    lsetup root
    lsetup xrootd
    lsetup rucio
    lsetup panda
    lsetup pyami

###########
# LXPLUS #
###########

elif [[ $HOSTNAME == *"lxplus"* ]]; then
    export CERN_USER=zmeadows
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'
    alias work='cd /afs/cern.ch/work/z/zmeadows/public'
    [[ -s /afs/cern.ch/user/z/zmeadows/.autojump/etc/profile.d/autojump.sh ]] && source /afs/cern.ch/user/z/zmeadows/.autojump/etc/profile.d/autojump.sh
    autoload -U compinit && compinit -u
    setupATLAS
    lsetup root
    lsetup xrootd
    lsetup rucio
    lsetup panda
    lsetup pyami

done
