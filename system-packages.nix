{ config, pkgs, ... }:

{
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
				pythonPackages.udiskie
				apulse
				pavucontrol
				pasystray
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
