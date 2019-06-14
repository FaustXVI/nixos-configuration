{ config, pkgs, ... }:

{
	programs.fish.enable = true;
	users = {
		mutableUsers = true; # when updating, set this to true, rebuild, then go back to false and rebuild and re change the password via passwd
		extraUsers = {
			xadet = {
				shell = pkgs.fish;
				isNormalUser = true;
				uid = 1000;
				createHome = true;
				extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "lp"];
				initialPassword = "changeMe";
			};
		};
	};
}
