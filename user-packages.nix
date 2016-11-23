{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				firefox
				emacs
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
