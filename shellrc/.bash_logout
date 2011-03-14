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
# ~/.bash_logout - Executed by bash(1) on logout, when shell exits.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
	[ -x "$(which clear_console)" ] && clear_console -q
fi
