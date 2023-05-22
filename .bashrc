BASHRC="~/.bashrc"


alias vi=vim

PRE_GO="clear"
POST_GO="pwd"
alias gobin="${PRE_GO} && cd ~/bin/ && ${POST_GO}"


BASHRC_BIN_PATHS=~/bin/bin_paths.sh
source ${BASHRC_BIN_PATHS}

alias bashsource="source ${BASHRC}"
alias bashedit="vi ${BASHRC} && read -p\"Source it?\" && bashsource"
alias bashgrep="grep $* ${BASHRC}"
alias basheditbinpaths="vi ${BASHRC_BIN_PATHS} && read -p\"Source it?\" && source ${BASHRC_BIN_PATHS}"

alias vimedit="vi ~/.vimrc"
alias vimpart="vi ~/.vimrc_parts"

alias sshcd="cd ~/.ssh/"
alias sshkeys="ssh-add -L"


SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" # > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


alias adas_pull="cd ~/dotfiles && git pull && cd ~/adaslove && git pull && cd ~/NeptunesCloud/ && git pull"
