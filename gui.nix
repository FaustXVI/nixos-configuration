{ config, pkgs, ... }:

{
	services = {
		xserver = {
			enable = true;
			synaptics = {
				enable = true;
				twoFingerScroll = true;
				tapButtons = true;
			};
			windowManager = {
				awesome = {
					enable = true;
				};
			};
			displayManager = {
				sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
			};
		};
	};
}
