# vim: set filetype=sh:
#
#            _|              _|          _|_|  _|  _|
#        _|_|_|    _|_|    _|_|_|_|    _|          _|    _|_|      _|_|_|
#      _|    _|  _|    _|    _|      _|_|_|_|  _|  _|  _|_|_|_|  _|_|
#      _|    _|  _|    _|    _|        _|      _|  _|  _|            _|_|
#  _|    _|_|_|    _|_|        _|_|    _|      _|  _|    _|_|_|  _|_|_|
#
# 			UNIX System Configuration Files
# 			     Underwares.org Systems
#
# 	     This file is part of the master distribution @ github
# 		      https://github.com/mrdaemon/dotfiles
#
#
# ~/.bashrc: Executed by bash(1) at startup. Also sourced from .profile
#            Also, this is bash(1) specific, I can do away with portability.
#

###########################################
# Interactive Sessions Parameters         #
# - loaded only for interactive sessions. #
###########################################

## No point in running anything past here if session
## isn't interactive in the least. Also, fuck checking for $PS1.
[[ $- != *i* ]] && return

###
# Bash shell Options
#####################

## Append history rather than overwrite
shopt -s histappend

## Ignore small typos in directory names during 'cd'
#shopt -s cdspell

## Check window size after each command, adjusting LINES and COLUMNS
shopt -s checkwinsize

## Validate that an entry in the hash table exists before blindly
## executing it. Prevents most '/usr/local/bin/derp: no such file or directory'
## errors, and saves on finger wear from typing 'hash -r'.
shopt -s checkhash

## Save multi-line commands as same history entries
shopt -s cmdhist

## Enabled extended pattern matching
shopt -s extglob

## if readline support is compiled it, allow to re-edit failed
## history substitutions
## (I have yet to meet a bash install that lacks readline.)
shopt -s histreedit

## Expand history substitutions into editing buffer for review,
## do not directory execute. That's much saner.
shopt -s histverify

## Enable programmable Completion
## Pretty sure it's on by default and that bash_completion enables it,
## but it never hurts to make sure.
shopt -s progcomp

## Enable completion of hostnames.
## On by default since what, 2.0? but better safe than sorry.
shopt -s hostcomplete

#### ---- Bash 4+ specific options ---- ####

if [[ ${BASH_VERSINFO[0]} -ge 4 ]] ; then
	## Automatically cd into directory names by calling them out
	## on the command prompt, without the need for explicit 'cd'
	#shopt -s autocd

	## List stopped/running jobs on 'exit' attempt, defers exit
	## until a second 'exit' is attempted without intervening command.
	shopt -s checkjobs

	## Enable recursive globbing with **/
	## Please picture thin lipped zsh users everywhere.
	shopt -s globstar
fi


###
# POSIX-style shell attributes/options
#########################################

## Don't wait for next prompt to notify of background job status changes.
set -o notify

## Enable !-powered shell history expansion. Most likely on by default.
set -o histexpand

## When cd'ing into symlinks, follow actual filesystem structure, don't
## pretend everything is visually okay while ../ won't do what you expect.
## Still debating wether or not to have this turned on by default.
# set -o physical

## Set shell editing to vi-mode, instead of default emacs mode.
## By the way, this forever changed my life. If you're a vi man, it will
## also change yours, guaranteed.
set -o vi

##
# History options
##################

## Don't log duplicate lines and keep previous settings
## that may have been set by external applications
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

## Ignore bullshit entries --
## job control, exit, ls, and most importantly, anything preceded by
## a space. Useful to explicitely run something without logging it to history.
HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls'

## Write line to disk whenever displaying prompt.
## Probably expensive, will definitely cause grief on IO-locked servers.
#PROMPT_COMMAND="$PROMPT_COMMAND${PROMPT_COMMAND+\;}history -a"
# -- or --
#PROMPT_COMMAND="history -a"

## Default history length
HISTSIZE=1000
HISTFILESIZE=2000

##
# Bash Completion options
##########################

# Allow completion of files checked out over passwordless ssh for CVS
COMP_CVS_REMOTE=1

# When completing './configure' scripts, do not strip description from
# options, ex: "./configure --with-option=description"
COMP_CONFIGURE_HINTS=1

# When completing tar files, don't flatten the paths.
COMP_TAR_INTERNAL_PATHS=1

# Load advanced bash completion if available at default location, and if
# it isn't already loaded from a system-wide script.
# Platforms where it's elsewhere can load it in their own location
if ! shopt -oq posix ; then
	if [[ -z $BASH_COMPLETION ]] ; then
		if [[ -f /usr/share/bash-completion/bash_completion ]] ; then
			source /usr/share/bash-completion/bash_completion
		elif [[ -f /etc/bash_completion ]] ; then
			source /etc/bash_completion
		fi
	fi
fi

## readline settings - overrides .inputrc

# Disable completion bell
bind "set bell-style none"

# Immediatly show completions instead of having to double-tab
bind "set show-all-if-ambiguous On"

##
# Hacks, gizmos and helpers
############################

## Debian Specific:
## set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

## Turn on color specific stuff if available
case "$TERM" in
	xterm-color|*-256color) enable_color=yes;;
esac

# In case of weird TERM value, test for ECMA-48 compliance with tput
# Enable color if that works out.
if [[ -z "$enable_color" ]] ; then
	if [[ -x /usr/bin/tput ]] && tput setaf 1 >& /dev/null ; then
		enable_color=yes
	else
		enable_color=
	fi
fi

## Enable lessopen(1) if available as a less filter.
## Enhances less' handling of binary files and compressed files.
[[ -x "$(which lesspipe)" ]] && eval "$(SHELL=/bin/sh lesspipe)"

## Enable color support for ls and friends, if available.
if [[ -x "$(which dircolors)" ]] && [[ $enable_color == "yes" ]] ; then
	# Prefer user defined colors
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	else
		eval "$(dircolors -b)"
	fi

	# Set default colored aliases
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi


## Setup Shell Prompt
## Any Dynamic stuff that expects to be part of PS1 should be hacked in here

if [[ $enable_color = yes ]] ; then
	# Build up the PS1 prefix (everything before the dynamic stuff)
	PS1PREFIX='${debian_chroot:+($debian_chroot)}' # Debian Chroot prefix

	PS1PREFIX="$PS1PREFIX"'\[\033[01;32m\]' # Switch to Green
	PS1PREFIX="$PS1PREFIX"'\u@\h'           # user@host
	PS1PREFIX="$PS1PREFIX"'\[\033[00m\]'    # Switch to white
	PS1PREFIX="$PS1PREFIX"':'               # Colon separator
	PS1PREFIX="$PS1PREFIX"'\[\033[01;34m\]' # Switch to Blue
	PS1PREFIX="$PS1PREFIX"'\w'              # Current Working Directory
	PS1PREFIX="$PS1PREFIX"'\[\033[00m\]'    # Switch back to white

	# Build up the PS1 suffix (everything after the dynamic stuff)
	PS1SUFFIX='\$ '

	# Set PS1 to initial value
	PS1="$PS1PREFIX""$PS1SUFFIX"

	# Setup git prompt if git is available
	if which git > /dev/null 2>&1 ; then
		if [[ -f ~/.git-prompt.sh ]] ; then
			. ~/.git-prompt.sh

			# Prompt Settings
			GIT_PS1_SHOWDIRTYSTATE=1
			GIT_PS1_SHOWUPSTREAM="auto"
			GIT_PS1_SHOWCOLORHINTS=1

			# __git_ps1 actually *modifies* PS1 outright.
			# The prefix and suffix variables need to stick around
			PROMPT_COMMAND='__git_ps1 "$PS1PREFIX" "$PS1SUFFIX"'
		fi
	else
		# Git prompt is not available, PS1 will remain intact.
		# We can clean up the garbage we'd otherwise leave behind.
		unset PS1PREFIX PS1SUFFIX
	fi
else
	# Don't actually mess with the prompt in a non-color env
	# This usually hints at console logins or recovery.
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Set the GUI terminal window title to PS1 info, if xterm compatible
case "$TERM" in
	xterm*|rxvt*)
    	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    	;;
	*)
    	;;
esac

# Add neat dbus notification alias to send the status of a pipeline
# Helpful to receive a desktop notification when something completes.
# e.g. /usr/bin/takes-forever --earthages=3 ; alertme
alias alertme='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alertme$//'\'')"'

##
# Global aliases
#################

## Make destructive operations interactive by default
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

## Load local bash-specific aliases if any
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

##
# Machine and system dependent Bashisms
########################################
[[ -f ~/.bashrc.local ]] &&  source ~/.bashrc.local

## Run terminal Welcome Mat if available
[[ -x ~/.rc.logo ]] && ~/.rc.logo

# Don't litter!
unset enable_color

####
