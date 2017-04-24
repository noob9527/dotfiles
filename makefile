apt-update: 
	sudo apt update

git-install:
	sudo apt install git

git-config:
	ln -fs "$$(pwd)/gitconfig" ~/.gitconfig
	ln -fs "$$(pwd)/gitignore" ~/.gitignore

node-install:
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | NVM_DIR="$$HOME/.nvm" bash
	nvm install node && nvm use node

npm-install:
	npm install cnpm -g
	cnpm install eslint -g 

vim-install:
	sudo apt remove vim vim-runtime gvim vim-tiny vim-common
	sudo apt install vim-gtx
	git clone vundle=git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	sudo apt install build-essential
	sudo apt install cmake
	~/.vim/bundle/YouCompleteMe/install.py --clang-completer --tern-completer
	sudo apt install silversearcher-ag
	sudo apt install exuberant-ctags

vim-config: 
	ln -fs "$$(pwd)/vimrc" ~/.vimrc
	mkdir ~/.vim/.undo_history
	vim +PluginInstall +qall

zsh-install:
	sudo apt install zsh
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sudo apt install autojump
	git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

zsh-config: 
	ln -fs "$$(pwd)/zshrc" ~/.zshrc

tmux-install: 
	sudo apt install tmux

tmux-config: 
	ln -fs "$$(pwd)/tmux.conf" ~/.tmux.conf

.PHONY: all install update vim tmux plugin
