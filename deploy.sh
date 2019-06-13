#!/usr/bin/env bash

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s .vimrc ~/
vim +BundleInstall +BundleClean! +qa
cp -r snippets/ ~/.vim/snippets/
cp -r colors/ ~/DotVim/colors/
ln -s tools/callgraph ~/bin/
ln -s tools/tree2dotx ~/bin/
