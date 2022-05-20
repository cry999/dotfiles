#!/bin/sh

workdir=$(mktemp -d)

pushd $workdir >/dev/null
# install vim
git clone --depth=1 https://github.com/vim/vim.git
pushd vim >/dev/null
make distclean
./configure \
	--with-features=huge \
	--enable-python3interp=huge \
	--enable-rubyinterp=huge
make
sudo make install

# install vim-package
vim \
	-c ":PlugInstall" \
	-c ":q" \
	-c ":q"
popd >/dev/null
popd >/dev/null
