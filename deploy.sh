#!/usr/bin/env bash

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp .vimrc ~/
vim +BundleInstall +BundleClean! +qa
cp -r snippets/ ~/.vim/snippets/
cp -r colors/ ~/DotVim/colors/
