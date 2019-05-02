# Dotfiles
> personal dotfiles to set up a new computer

### Prerequisites
- apt-get or brew

### Getting Started
Download or clone the project, do not forget the submodules.
```bash
git clone --recursive
```
Update the configuration to specify which task should be run, finally, run the executable files with specified configuration.
```bash
./bin/dotfiles -c ./config/config.yml
```

### Configuration Tasks(all items are supposed to be optional)
- git
    1. install git
    1. copy .gitconfig
    1. link .gitignore
    1. configure git user info globally
- shadowsocks
    1. install shadowsocks client(ss-qt5)
- tools
    1. install pip2
    1. install pip3
    1. install curl
    1. install build\_essential
    1. install cmake
    1. install ag
    1. install powerline
    1. install reattach-to-user-namespace(OSX)
    1. install autojump
    1. install [translate-shell](https://github.com/soimort/translate-shell)
- java
    1. install jdk(default-jdk)
- node
    1. install nvm
    1. install node via nvm
    1. install common global package
- vim
    1. install or reinstall vim(vim-gtk in Debian)
    1. install vundle
    1. link .vimrc, .tern-config
    1. install vim plugin via vundle
    1. build YCM plugin
- shells
    1. link .functions.sh file(it then will be sourced by .exports file)
    1. link .exports file(should be read by bash and zsh)
- bash
    1. link .bash\_profile
- zsh
    1. install zsh
    1. install oh-my-zsh
    1. install zsh-autosuggestions
    1. link .zshrc
- tmux
    1. install tmux
    1. install(clone) tpm
    1. link .tmux.conf
- miscellaneous
    1. link .ideavimrc
    1. terminal add monokai(customized version) profile
    1. link ~/.ssh/config
    1. execute ssh-keygen
- docker
    1. install docker-ce
    1. copy daemon.json(to use alibaba mirror)
    1. install docker-compose
- k8s
    1. install kubectl
    1. install minikube

### TODO
- [httpie](https://github.com/jakubroztocil/httpie)
- [http-prompt](https://github.com/eliangcs/http-prompt)
- mycli
- pgcli
- sdkman
- gradle
