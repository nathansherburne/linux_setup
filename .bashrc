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
export PROMPT_COMMAND='PS1="\[\e[1;32m\]\u@\[\e[1;32m\]\h \[\e[m\]\[\e[1;34m\]"$(python ~/.short.pwd.py)"\[\e[m\] : "'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Use Vim as default (Git, ...)
export VISUAL=vim
export EDITOR="$VISUAL"

