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
# ~/.bashrc             -  Bash specific configuration, sourced by profile and 
#                          non-login shells.
#
# ~/.bashrc.local       -  Bash specific configuration for local machine.
#                          Sourced by ~/.bashrc in strategic spots.
#
# $DOTFILES/            -  shell/rc.d optional/specific configuration files
#  --> <platform>.profile     - Platform specific login shell configuration
#  --> <hostname>.profile     - Machine specific login shell configuration
#
# $DOTFILES/bashisms -  Bash specific scripts and configurations.
#  --> <platform>.bashrc      - Configuration specific to <platform>
#  --> <hostname>-ps1.bash    - Shell prompt specific to <hostname>
#

###
# Global environment Variables
###############################

DOTFILES="$HOME/.shell/rc.d" # Where to find 'dotfiles/shell/rc.d/' directory
export DOTFILES

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

# I sometimes keep a $HOME/local as to not litter the root,
# especially if a package is more than a single binary.
# I find installing directly in $HOME distasteful.
if [ -d "$HOME/local" ] ; then
	PATH="$HOME/local/bin:$PATH"
	MANPATH="$HOME/local/share/man:$MANPATH"
	INFOPATH="$HOME/local/share/info:$INFOPATH"
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

# Don't litter!
unset DOTFILES

# Export variables
export PATH
export MANPATH
export INFOPATH
export EDITOR
export PAGER
export VISUAL
export SVN_EDITOR
export GIT_EDITOR
