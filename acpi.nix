{ config, pkgs, ... }:

{

	environment.systemPackages = with pkgs; [
		acpi
	];

	services = {
		acpid = {
			enable = true;
		};
	};

    services = {
      logind = {
        extraConfig = ''
        # don’t shutdown when power button is short-pressed
        HandlePowerKey=ignore
        '';
      };
    };
}
