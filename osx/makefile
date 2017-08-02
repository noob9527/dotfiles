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
	brew install vim \
		--with-lua \
		--with-python3 \
		--with-override-system-vi

vim-plugin-install:
	brew install cmake
	brew install the_silver_searcher
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	ln -fs "$$(dirname "$$(pwd)")/vimrc" ~/.vimrc
	vim +PluginInstall +qall
	ln -fs "$$(dirname "$$(pwd)")/tern-config" ~/.tern-config
	~/.vim/bundle/YouCompleteMe/install.py --clang-completer --tern-completer
	mkdir ~/.vim/.undo_history

zsh-install:
	brew install zsh
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	brew install autojump
	git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

zsh-config:
	ln -fs "$$(dirname "$$(pwd)")/zshrc" ~/.zshrc
	ln -fs "$$(dirname "$$(pwd)")/exports" ~/.exports

tmux-install: 
	brew install tmux
	brew install python
	pip install powerline-status
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	brew install reattach-to-user-namespace

tmux-config: 
	ln -fs "$$(pwd)/tmux.conf" ~/.tmux.conf

ssh-config:
	ln -fs "$$(dirname "$$(pwd)")/.ssh/config" ~/.ssh/config

.PHONY: all install zsh-install zsh-config
