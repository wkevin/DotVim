#!/usr/bin/env bash

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s $PWD/.vimrc ~/
vim +BundleInstall +BundleClean! +qa
cp -r snippets/ ~/.vim/snippets/
cp -r colors/ ~/DotVim/colors/
ln -s $PWD/tools/callgraph ~/bin/
ln -s $PWD/tools/tree2dotx ~/bin/
