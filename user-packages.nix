{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				firefox-esr
				emacs
				xpdf
				vlc
				slack
		];
	};

	nixpkgs = {
		config = {
			firefox = {
                enableGoogleTalkPlugin = true;
				enableAdobeFlash = true;
			};
		};
	};

}
