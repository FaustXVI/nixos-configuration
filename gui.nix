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
			monitorSection = ''
				Modeline "2560x1080_40.00"  147.25  2560 2680 2944 3328  1080 1083 1093 1108 -hsync +vsync
				Option "PreferredMode" "2560x1080_40.00"
			'';
			#xrandrHeads = [ "DVI-I-2" "DVI-I-1" ];
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
