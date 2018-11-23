#
# ~/.bash_logout
#
[ "$TERM" = "linux" ] && [ -z $SSH_TTY ] && \
    sudo splash_manager -c set --theme="$TTY_LOGIN_THEME"
