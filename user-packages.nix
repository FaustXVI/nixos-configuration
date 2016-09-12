{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				firefox
				emacs
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
