{ config, pkgs, ... }:
{
	imports = [
		./hardware-configuration.nix
	]
		
	networking.hostName = "elaines-x1";
	
	# biometric logins/passkeys
	services.fprintd.enable = true;
	services.fprintd.tod.enable = true;
	services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

	# hardware management
	services.thermald.enable = true;
	services.tlp.enable = true;
	services.power-profiles-daemon.enable = false;

	# trackpoint
	hardware.trackpoint = {
		enable = true;
		speed = 70;
		sensitivity = 100;
	};
}
