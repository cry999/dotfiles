# --- Golang ---
if ! which go >/dev/null ; then
  return 0
fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
