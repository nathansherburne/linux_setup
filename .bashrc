# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Virtualenv/VirtualenvWrapper
#source `which virtualenvwrapper.sh`

# Make pretty terminal prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

format_git_branch() {
    if [ "$(parse_git_branch)" != "" ]; then
        echo " ($(parse_git_branch))"
    fi
}

parse_venv() {
    if [ "$VIRTUAL_ENV" != "" ]; then
	echo "(${VIRTUAL_ENV##*/})"
    fi
}

if [ "$IN_GIT_SESH" != 1 ]; then
    export PROMPT_COMMAND='PS1=$(parse_venv)"\[\e[1;32m\]\u@\[\e[1;32m\]\h \[\e[m\]\[\e[1;34m\]"$(python ~/.short.pwd.py)"\[\e[m\]\$(format_git_branch)\[\033[00m\] : "'
fi
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Use Vim as default (Git, ...)
export VISUAL=vim
export EDITOR="$VISUAL"

# Composer
export PATH=$PATH:~/.composer/vendor/bin

# My executables
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/php

# Git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source ~/.local/bin/virtualenvwrapper.sh
export WORKON_HOME=/home/nathan/.virtualenvs
export PIP_VIRTUALENV_BASE=/home/nathan/.virtualenvs

# Add virtualenv name to prompt (didn't work at first because of PROMPT_COMMAND git branch setup ^^


# PYTHONPATH for ads
export PYTHONPATH=$PYTHONPATH:/home/nathan/docker/amazon-data-service

# Python Shell
export PYTHONSTARTUP=~/.pythonrc
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

bind  "\C-e":clear-screen
