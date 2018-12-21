## Custom directories
alias apa="cd /etc/apache2/sites-available/"
alias ngi="cd /etc/nginx"

## Changing Aliases & Hosts
alias nba="nano ~/.bash_aliases"
alias eba="emacs ~/.bash_aliases"
alias sba="source ~/.bash_aliases"
alias snh="sudo nano /etc/hosts"

## Directory listings
alias ls="ls -h"                   # Override default ls
alias la="ls -lA"                  # Long listing format
alias ll="ls -alF"                 # 
alias lt="ls -lAt | head -21"      # 
alias lr="ls -lAtr | head -21"     # 
alias las="ls -lAS"                # 
alias lc="ls | wc -l"              # 

## Directory changing
alias cd..='cd ..'                 # Prevent command not found
alias ..='cd ..'                   # 
alias ...='cd ../..'               # 
alias ....='cd ../../..'           # 
alias .....='cd ../../..'          # 
alias ......='cd ../../../..'      # 
alias .......='cd ../../../../..'  # 
alias .2='cd ../..'                # 
alias .3='cd ../../..'             # 
alias .4='cd ../../../..'          # 
alias .5='cd ../../../../..'       # 
alias .6='cd ../../../../../..'    # 
alias .7='cd ../../../../../../..' # 

alias cd1='cd $(dirNum 1)'
alias cd2='cd $(dirNum 2)'
alias cd3='cd $(dirNum 3)'
alias cd4='cd $(dirNum 4)'

alias cat1='cat $(fileNum 1)'
alias cat2='cat $(fileNum 2)'
alias cat3='cat $(fileNum 3)'
alias cat4='cat $(fileNum 4)'

alias less1='less -S $(fileNum 1)'
alias less2='less -S $(fileNum 2)'
alias less3='less -S $(fileNum 3)'
alias less4='less -S $(fileNum 4)'

# Get the nth lastest directory by name
function dirNum() {
  ls -lt | grep ^d | sed "$1q;d" | awk '{print $9}'
}
function fileNum() {
  ls -lt | grep ^- | sed "$1q;d" | awk '{print $9}'
}

## Checking size
alias df="df -H"                   # 
alias du="du -h"                   #
alias dc="du -ch"                  # 
alias ds="du -sh"                  # 

## System info & memory 
alias meminfo='free -m -l -t'                                   # Pass options to free
alias psmem='ps auxf | sort -nr -k 4'                           # Get processes eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10'              # Get top processes eating memory
alias pscpu='ps auxf | sort -nr -k 3'                           # Get processes eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'              # Get top processes eating cpu
alias cpuinfo='lscpu'                                           # Get server cpu info
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'   # Get GPU ram on desktop / laptop

## iptable view & edit
alias ipt='sudo /sbin/iptables'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

## Windows CMD Conversions
alias cls="clear"                  # Clear the screen
alias c="clear"                    # Clear the screen
alias cl="clear; la"               # Clear the screen
alias ipconfig="ifconfig"          # Show network interface parameters

## Searching
alias fd="find . -type d -name"      # Find directory by name
alias ff="find . -type f -name"      # Find file by name
function hg() {
  history | grep "$1"
}

alias ls="ls --color"
alias src="source ~/.bashrc; cd -"
alias seed="php artisan migrate:refresh --seed"
alias phptest="db_reset && vendor/bin/phpunit --no-coverage"
alias phplint="/home/nathan/repos/ngis-listener/vendor/bin/phpcs --standard=/home/nathan/repos/ngis-listener/vendor/etoolz/standards/src/ruleset.xml -s"
alias phpfixer="/home/nathan/repos/ngis-listener/vendor/bin/phpcbf -n"
alias open="xdg-open"
alias ngis="cd ~/repos/ngis-listener"
alias ads="cd ~/docker/amazon-data-service"
alias gitsesh="source ~/.git_bash_aliases"
alias viml="vim /home/nathan/.vim/global_marks.txt"

vilast() {
  vim $(ls | tail -1)   
}

alias drop_all_mysql="mysql -u root -p'qu!Ck5iLv3r' -P 3306 -h 172.16.144.241 -e 'DROP DATABASE \`nathan-ngis\`; CREATE DATABASE \`nathan-ngis\`;'"
alias ads="cd ~/docker/amazon-data-service"
cctg() {
    vim -c 'execute "normal gg:/logging\rvat\\c:wq\r"' phpunit.xml
}

db_reset() {
    composer dump-autoload 
    composer clear-cache 
    drop_all_mysql
    seed
}
