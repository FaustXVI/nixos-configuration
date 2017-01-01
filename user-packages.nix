{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				firefox
				emacs
				xpdf
				vlc
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
