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
				bashCompletion
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
