{ config, pkgs, ... }:

{
	users = {
		mutableUsers = true; # when updating, set this to true, rebuild, then go back to false and rebuild and re change the password via passwd
		extraUsers = {
			xadet = {
				isNormalUser = true;
				uid = 1000;
				createHome = true;
				extraGroups = [ "networkmanager" "wheel" "docker"];
				initialPassword = "changeMe";
			};
		};
	};
}
