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
# ~/.profile: Executed by the command interpreter for login shells.
#             Generic, shell agnostic configuration. Not read by bash(1) if
#             ~/.bash_profile or ~/.bash_login exists. Keep portable.
#
# ----------------------------------------------------------------------------
# File layout overview:
#
# ~/.profile            -  Master file. Executed by interpreters for
#                          login shells. Sadly not executed by non-login ones.
#
# ~/.profile.local      -  Machine specific local profile stuff (paths etc).
#                          Sourced by .profile if found.
#
# ~/.bashrc             -  Bash specific configuration, sourced by profile and
#                          non-login shells.
#
# ~/.bashrc.local       -  Bash specific configuration for local machine.
#                          Sourced by ~/.bashrc in strategic spots.

###
# Global environment Variables
###############################

# Use less as pager, if it is available
if [ -n "`which less`" ] ; then
	PAGER=less
else
	PAGER=more
fi

# Set global editor to vim or vi
if [ -n "`which vim`" ] ; then
	EDITOR=vim
else
	EDITOR=vi
fi

###
# Generic PATH setup
#####################

# Include personal 'bin' directory
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# Add local bin and man page paths
if [ -d "$HOME/.local" ] ; then
	PATH="$HOME/.local/bin:$PATH"
	if [ -z "$MANPATH" ] ; then
		MANPATH="$HOME/.local/share/man:`manpath -q`"
	else
		MANPATH="$HOME/.local/share/man:$MANPATH"
	fi
	INFOPATH="$HOME/.local/share/info:$INFOPATH"
fi

# VI(M) EVERYWHERE, ALWAYS, ALL THE TIME
VISUAL=$EDITOR
SVN_EDITOR=$EDITOR
GIT_EDITOR=$EDITOR

###
# Specific hooks and shell configurations
###########################################

# Execute bashrc if running bash.
if [ -n "$BASH_VERSION" ]; then
	if [ -r "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# Export variables
export PATH
export MANPATH
export INFOPATH
export EDITOR
export PAGER
export VISUAL
export SVN_EDITOR
export GIT_EDITOR

# Source local profile if available
if [ -f "$HOME/.profile.local" ] ; then
	. "$HOME/.profile.local"
fi

##