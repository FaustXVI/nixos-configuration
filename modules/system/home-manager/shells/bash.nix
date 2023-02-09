{...}:
{
  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
# If not running interactively, don't do anything
        [ -z "$PS1" ] && return

# append to the history file, don't overwrite it
        shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
        shopt -s checkwinsize

        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'

# some more ls aliases
        alias ll='ls -l'
        alias la='ls -A'
        alias l='ls -CF'

        if [ -f ~/.bashrc_for_profile ]; then
        . ~/.bashrc_for_profile
        fi

        eval "$(direnv hook bash)"
      '';
    };
  };
}
