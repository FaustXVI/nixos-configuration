#!/usr/bin/env bash

INSTALL_ROOT="/mnt"
CONFIG_PATH="$INSTALL_ROOT/home/xadet/.config"
GITHUB_HTTP="http://github.com/FaustXVI"
GITHUB_SSH="git@github.com:FaustXVI"

clone() {
    git clone $GITHUB_HTTP/$1 $CONFIG_PATH/$2
    cd $CONFIG_PATH/$2
    git remote set-url origin $GITHUB_SSH/$1.git
    cd -
}

cd /etc/nixos
git remote set-url origin $GITHUB_SSH/nixos-configuration.git
cd -

mkdir -p $CONFIG_PATH
clone nixos-xadet-configuration nixpkgs
clone omf-config omf
nixos-enter --root $INSTALL_ROOT -c 'mv /etc/nixos /home/xadet/nixos-configuration'
nixos-enter --root $INSTALL_ROOT -c 'ln -s /home/xadet/nixos-configuration /etc/nixos'
chown --reference=/mnt/home/xadet -R /mnt/home/xadet

mount -o bind,ro /etc/resolv.conf $INSTALL_ROOT/etc/resolv.conf
nixos-enter --root $INSTALL_ROOT -c 'su xadet -l -c "curl -L https://get.oh-my.fish | fish"'
nixos-enter --root $INSTALL_ROOT -c 'su xadet -l -c "nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager"'
nixos-enter --root $INSTALL_ROOT -c 'su xadet -l -c "nix-shell https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager -A install"'
nixos-enter --root $INSTALL_ROOT -c 'su xadet -l -c "home-manager switch"'

