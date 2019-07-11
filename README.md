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
#### essential
- remap caps
- git
  1. install git
  1. copy .gitconfig
  1. link .gitignore
  1. configure git user info globally
- curl
- net-tools
- build-essential
- make
- cmake

#### proxy
- shadowsocks client(ss-qt5)
- proxychains

#### programming
- python
  1. install pip2
  1. install pip3
- java
  1. install jdk(default-jdk)
- node
  1. install nvm
  1. install node via nvm
  1. install common global package
- go
- rust

#### container
- docker
    1. install docker-ce
    1. copy daemon.json(to use alibaba mirror)
    1. install docker-compose
- k8s
    1. install kubectl
    1. install virtualbox virtualbox-ext-pack
    1. install minikube

#### terminal
- shells
    1. link .functions.sh file(it then will be sourced by .exports file)
    1. link .exports file(should be read by bash and zsh)
- ssh
    1. link ~/.ssh/config
    1. execute ssh-keygen
- bash
    1. link .bash\_profile
- vim
    1. install or reinstall vim(vim-gtk in Debian)
    1. install vundle
    1. link .vimrc, .tern-config
    1. install vim plugin via vundle
    1. build YCM plugin
- zsh
    1. install zsh
    1. install oh-my-zsh
    1. install zsh-autosuggestions
    1. link .zshrc
- tmux
    1. install tmux
    1. install(clone) tpm
    1. link .tmux.conf

#### miscellaneous
- .ideavimrc

#### gui
- [albert](https://github.com/albertlauncher/albert)
- [zeal](https://zealdocs.org/download.html#linux)
- gnome-terminal 
  1. add monokai(customized version) profile

#### cmd-tools
- xclip
- autojump
- ag
- powerline
- [hub](https://github.com/github/hub)

### candidates list
- chrome-gnome-shell
- wine
- sogou-pinyin
- netease-music

- sdkman
- gradle(apt 4.4)

### gnome extensions
Sadly, I have to install gnome extensions manually for the time being.
- [dash-to-panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [system-monitor](https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet)
- [arc-menu](https://extensions.gnome.org/extension/1228/arc-menu/)
- [Panel OSD](https://extensions.gnome.org/extension/708/panel-osd/)
- [open-weather](https://extensions.gnome.org/extension/750/openweather/)
- [topicons](https://extensions.gnome.org/extension/1031/topicons/)
- [refresh wifi connections](https://extensions.gnome.org/extension/905/refresh-wifi-connections/)

#### known issues
