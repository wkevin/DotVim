# DotVim is .vim

To git push my .vim folder is better than to put all script install package on cloud driver. So, do it.

## Usage

### Linux

```
$cd ~
$mv .vim .vimbak
$sudo yum install ctags
$git clone https://github.com/wkevin/DotVim.git .vim
$cp .vim/.vimrc ./
```

### Windows
```
1. download ctags for windwos,unrar it, and add the path to $PATH
2. find or modify your $HOME 
3. cd $HOME
4. git clone https://github.com/wkevin/DotVim.git vimfiles
```
other info:
* `:version` check the path to looking for vimrc file 