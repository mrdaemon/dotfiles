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
# ~/.bashrc: Executed by bash(1) at startup. Login or non login, unlike most
#            traditional UNIX systems, I don't give a crap and execute it from
#            ~/.profile regardless, because I'm cool like that.
#            Also, this is bash(1) specific, I can do away with portability
#            and go back to feeling sane and content.
#

## Silently Source bootstrap script if somehow ran without .profile ##
f="$HOME/.bootstrap.rc"
[[ "$BOOTSTRAPPED"]] || [[ -r "$f" ]] && { source "$f" &>/dev/null ; }
unset -v f

###########################################
# Interactive Sessions Parameters         #
# - loaded only for interactive sessions. #
###########################################

## No point in running anything past here if session
## isn't interactive in the least. Also, fuck checking for $PS1,
## really. Not sure why some seem to think it's a brilliant idea.
[[ $- != *i* ]] && return

###
# Bash shell Options
#####################

## Append history rather than overwrite
shopt -s histappend

## Ignore small typos in directory names during 'cd'
shopt -s cdspell

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

## Enable completion of hostnames.
## On by default since what, 2.0? but better safe than sorry.
shopt -s hostcomplete

#### ---- Bash 4+ specific options ---- ####

if [[ $BASH_VERSINFO[0] -ge 4 ]] ; then
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

##
# Global aliases
#################

## Make destructive operations interactive by default
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

## Load bash-specific aliases if any
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases


