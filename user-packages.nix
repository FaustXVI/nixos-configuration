{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				firefox
				emacs
				terminator
				xpdf
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
