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

mkdir -p $CONFIG_PATH
clone nixos-xadet-configuration nixpkgs
clone omf-config omf
chown --reference=/mnt/home/xadet -R /mnt/home/xadet

mount -o bind,ro /etc/resolv.conf $INSTALL_ROOT/etc/resolv.conf
nixos-enter --root $INSTALL_ROOT -c 'sudo -u xadet "home-manager switch"'
