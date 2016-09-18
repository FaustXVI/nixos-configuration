{ config, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
				dmenu
				i3status
				i3lock
		];
	};
	services = {
		xserver = {
			enable = true;
			synaptics = {
				enable = true;
				twoFingerScroll = true;
				tapButtons = true;
			};
			windowManager = {
				i3 = {
					enable = true;
				};
			};
			displayManager = {
				sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
			};
		};
	};
}
