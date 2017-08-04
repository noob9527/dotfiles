apt-update: 
	sudo apt update

git-install:
	sudo apt install git

git-config:
	ln -fs "$$(dirname "$$(pwd)")/gitconfig" ~/.gitconfig
	ln -fs "$$(dirname "$$(pwd)")/gitignore" ~/.gitignore

node-install:
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | NVM_DIR="$$HOME/.nvm" bash
	nvm install node && nvm use node

npm-install:
	npm install typescript
	npm install -g eslint babel-eslint tslint
	npm install -g \
		eslint-plugin-flowtype \
		eslint-plugin-react \
		eslint-plugin-jsx-a11y \
		eslint-plugin-import
	npm install -g eslint-config-airbnb eslint-config-airbnb-base
	npm install -g js-beautify typescript-formatter

vim-install:
	sudo apt remove vim vim-runtime gvim vim-tiny vim-common
	sudo apt install vim-gtx

vim-plugin-install:
	sudo apt install build-essential
	sudo apt install cmake
	sudo apt install silversearcher-ag
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	ln -fs "$$(dirname "$$(pwd)")/vimrc" ~/.vimrc
	vim +PluginInstall +qall
	ln -fs "$$(dirname "$$(pwd)")/tern-config" ~/.tern-config
	~/.vim/bundle/YouCompleteMe/install.py --clang-completer --tern-completer
	mkdir ~/.vim/.undo_history

zsh-install:
	sudo apt install zsh
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sudo apt install autojump
	git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

zsh-config: 
	ln -fs "$$(dirname "$$(pwd)")/zshrc" ~/.zshrc
	ln -fs "$$(dirname "$$(pwd)")/exports" ~/.exports

tmux-install: 
	sudo apt install tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux-config: 
	ln -fs "$$(pwd)/tmux.conf" ~/.tmux.conf

ssh-config:
	ln -fs "$$(dirname "$$(pwd)")/.ssh/config" ~/.ssh/config

android-env-install:
	sudo apt-get install libz1 libncurses5 libbz2-1.0:i386 libstdc++6 libbz2-1.0

chore:
	# ideavim
	ln -fs "$$(dirname "$$(pwd)")/ideavimrc" ~/.ideavimrc

.PHONY: all install update vim tmux plugin
