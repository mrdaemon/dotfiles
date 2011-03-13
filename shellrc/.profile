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
#                          non-login shells
#
# ~/.bootstrap.rc       -  Contains init-related hacks, hooks and helpers.
# ~/.bootstrap.rc.conf  -  Global bootstrap settings (local to each system) 
#                          You **MUST** edit this to match your system.
#                          Do note that you can hardcode values there.
#
# $DOTFILES/bashisms -  Bash specific scripts and configurations.
#  --> <platform>.bash        - Configuration specific to <platform>
#  --> <hostname>-ps1.bash    - Shell prompt specific to <hostname>
#  --> <hostname>-local.bash  - Configuration specific to <hostname>

###
# Self-checks and system bootstrap
###################################

# Execute bootstrap script for hooks and helpers
if [ -r "$HOME/.bootstrap.rc" ] ; then
	. "$HOME/.bootstrap.rc"
else
	echo "PROFILE: WARNING - $HOME/.bootstrap.rc is missing." 1>&2
	echo "PROFILE: Nifty hacks and automation are disabled." 1>&2
	echo "PROFILE: Verify permissions, symlinks and overall sanity." 1>&2
fi

###
# Global environment Variables
###############################

# export path to dotfiles repository location.
# Set by bootstrap script above, which is sourced.
if [ -n "$DOTFILES" ] ; then
       export DOTFILES
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
if [ -d "$HOME/local/bin" ] ; then
	PATH="$HOME/local/bin:$PATH"
fi

###
# Specific hooks and shell configurations
###########################################

# Execute bashrc if running bash.
if [ -n "$BASH_VERSION" ]; then
	if [ -r "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# Attempt to Cleanup boostrap crud.
# TODO: Script could be autogen'ed, actually.
c="$DOTFILES/shellrc/.bootstrap-cleanup.rc"
if [ -r "$c" ] ; then
	. "$c"
fi
unset -v c

# Export variables
export PATH


