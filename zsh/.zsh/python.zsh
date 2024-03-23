# --- PYTHON ---
if ! which python >/dev/null && ! which python3 >/dev/null ; then
  return 0
fi

export SETUPTOOLS_USE_DISTUTILS=stdlib # suppress ModuleNotFoundError: No module named 'setuptools._distutils'
export PYTHONSTARTUP=$HOME/.pythonstartup.py
export PATH=$PATH:~/.pyenv/shims

if which pyenv >/dev/null 2>&1; then
	eval "$(pyenv init -)"
	export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
fi

