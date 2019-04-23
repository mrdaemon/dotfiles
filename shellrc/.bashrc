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
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

## Ignore bullshit entries --
## job control, exit, ls, and most importantly, anything preceded by
## a space. Useful to explicitely run something without logging it to history.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls'

## Write line to disk whenever displaying prompt.
## Probably expensive, will definitely cause grief on IO-locked servers.
#export PROMPT_COMMAND="$PROMPT_COMMAND${PROMPT_COMMAND+\;}history -a"
# -- or --
#export PROMPT_COMMAND="history -a"

## Use giant history file size
export HISTSIZE=10000

##
# Bash Completion options
##########################

# Allow completion of files checked out over passwordless ssh for CVS
export COMP_CVS_REMOTE=1

# When completing './configure' scripts, do not strip description from
# options, ex: "./configure --with-option=description"
export COMP_CONFIGURE_HINTS=1

# When completing tar files, don't flatten the paths.
export COMP_TAR_INTERNAL_PATHS=1

## readline settings - overrides .inputrc ##

# Disable completion bell
bind "set bell-style none"

# Immediatly show completions instead of having to double-tab
bind "set show-all-if-ambiguous On"

# Load advanced bash completion if available at default location, and if
# it isn't already loaded from a system-wide script.
# Platforms where it's elsewhere can load it in their own location
[[ -r /etc/bash_completion && -z "$BASH_COMPLETION" ]] && \
	source /etc/bash_completion

##
# Global aliases
#################

## Make destructive operations interactive by default
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

## Load bash-specific aliases if any
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

##
# Hacks, gizmos and helpers
############################

## Enable lessopen(1) if available as a less filter.
## Enhances less' handling of binary files and compressed files.
[[ -x "$(which lesspipe)" ]] && eval "$(lesspipe)"

## Enable color support for ls, if available.
if [[ -x "$(which dircolors)" ]] ; then
	# Prefer user defined colors
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	else
		eval "$(dircolors -b)"
	fi
fi

##
# User functions
#################

# Set xterm-ish window title
set_xtitle () { echo -ne "\e]2;$@\a\e]1;$@\a"; }

##
# Machine and system dependent Bashisms
########################################



# Don't litter!


