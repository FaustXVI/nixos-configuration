{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				firefox
				emacs
				terminator
		];
	};

	nixpkgs = {
		config = {
			firefox = {
				enableAdobeFlash = true;
			};
		};
	};

}
