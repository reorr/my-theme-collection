### KAWAII-TERMINAL!
#export TERM=xterm-256color
## ログイン時にアスキーアートを流す
#AA_1=$HOME/Saus/kawaii-term/asciiarts/sigure.ansi
#cat $AA_1
## custom busyboxの使用を許可する
#export PATH=$HOME/Saus/kawaii-term/bin:$PATH
## lコマンドをls -CFとメタ情報の表示に割り当てる
#function L() {
#  echo "はわわ〜〜〜！💦";
#  ls -CF;
#}
#alias l=L
## pコマンドをpwdに割り当てる　
#alias p=pwd
#FREE_MEM()
#{
#   python3 $HOME/Saus/kawaii-term/kawaii-term.py --mem
#}
#CPU_USAGE()
#{
#  python3 $HOME/Saus/kawaii-term/kawaii-term.py --vmstat
#}
#DISK_USAGE(){
#  python3 $HOME/Saus/kawaii-term/kawaii-term.py --disk
#}
#GET_WEATHER() {
#  python3 $HOME/Saus/kawaii-term/weather.py
#}
#RIGHT_PRONPT()
#{
  # パディング幅を%*s ${COLUMNS}で指定できるが、tmux経由だと、よく破綻しているので、ハードコードでもいいかもしれない
  #printf "%*s" 240 "$(tput setaf 199)$(tput bold)$(CPU_USAGE)$(tput sgr0) $(tput setaf 2)$(DISK_USAGE) $(tput setaf 123)[TENKI:$(GET_WEATHER)]$(tput sgr0)"
 # printf "%*s" 240 "$(tput setaf 199)$(tput bold)$(CPU_USAGE)$(tput sgr0) $(tput setaf 2)$(DISK_USAGE)"
#}

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/reorr/.sdkman"
[[ -s "/home/reorr/.sdkman/bin/sdkman-init.sh" ]] && source "/home/reorr/.sdkman/bin/sdkman-init.sh"

alias wm='sudo wifi-menu -o wlp3s0'
export WINEARCH=win32
export WINEPREFIX=~/win32
export PATH="$(yarn global bin):$PATH"
alias nfetch='neofetch --wm Pictures/ava/sayori.png'
alias mati='poweroff'
alias konek='ping 8.8.8.8'
alias hai='startx'
alias ig='/opt/Ramme/ramme'
alias musik='ncmpcpp -c ~/.ncmpcpp/ncmpcpp-albumart'
alias xfwm-logout='killall xfwm4-session.sh'
alias xfhai='startx ~/.xinitrc xfwm'
alias noalbum='ncmpcpp -c .ncmpcpp/ncmpcpp-noalbumart'
alias albumviz='ncmpcpp -c .ncmpcpp/ncmpcpp-albumartviz -S visualizer'
#export PS1='$(free_mem) prompt > '
#GREEN="\[$(tput setaf 2)\]"
#PINK="\[$(tput setaf 199)\]"
#YELLOW="\[$(tput setaf 220)\]"
#ORANGE="\[$(tput setaf 202)\]"
#BLUE="\[$(tput setaf 33)\]"
#CYAN="\[$(tput setaf 111)\]"
#RESET="\[$(tput sgr0)\]"
#ULINE="\[$(tput smul)\]"
#EULINE="\[$(tput rmul)\]"
#BOLD="\[$(tput bold)\]"
#STIM="\[$(tput sitm)\]" # 斜線開始
#RTIM="\[$(tput ritm)\]" # 斜線終了
#BCC_T="\[$(tput setb 7)\]"
#WHOAMI="⚡ "
#export PS1="\[\$(tput sc; RIGHT_PRONPT; tput rc)\]$WHOAMI${BCC_T}${BOLD}${YELLOW}@${RESET} ${STIM}${CYAN}[\$(FREE_MEM)]${RESET}${RTIM} ${ULINE}${ORANGE}192.168.15.19${RESET}${EULINE} ${BOLD}${BLUE}=>${RESET}"
PS1='\W \$ '
