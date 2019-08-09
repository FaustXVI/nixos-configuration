{ config, pkgs, ... }:

{
  imports = [
    "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ];
	environment = {
		variables = {
			EDITOR = pkgs.lib.mkOverride 0 "vim";
		};
		systemPackages = with pkgs; [
				wget
				git
				vim
				usbutils
				tree
				gnupg
				file
				gnumake
				automake
				gcc
				aspell
				aspellDicts.en
				aspellDicts.fr
				direnv
				terminator
				zip
				unzip
				udiskie
				apulse
				pavucontrol
				pasystray
				autorandr
				powerline-fonts
				xorg.xbacklight
				yubico-piv-tool
				yubikey-personalization
				yubikey-personalization-gui
				yubioath-desktop
                home-manager
		];
	};
	programs = {
		bash = {
			enableCompletion = true;
		};
		ssh = {
			startAgent = false;
		};
	};
}
