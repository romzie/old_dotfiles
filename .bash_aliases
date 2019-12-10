alias shutdown='/sbin/shutdown -h now'
alias hibernate='systemctl hibernate'
alias suspend='systemctl suspend'

alias vpnimag='sudo vpnc-connect'
alias vpnoff='sudo vpnc-disconnect'
alias sshimag='ssh piersonr@depots.ensimag.fr -t ssh piersonr@pcserveur.ensimag.fr'
alias sshXimag='vpnimag && ssh -X piersonr@pcserveur.ensimag.fr'

alias projmid='xrandr --output VGA-0 --same-as LVDS'
alias projright='xrandr --output VGA-0 --right-of LVDS'
