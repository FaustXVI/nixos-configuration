{ config, pkgs, ... }:

{
	users = {
		extraUsers = {
			xadet = {
				isNormalUser = true;
				uid = 1000;
				createHome = true;
				extraGroups = [ "networkmanager" "wheel" ];
				initialPassword = "changeMe";
			};
		};
	};
}
