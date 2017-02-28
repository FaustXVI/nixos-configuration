# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			../commons.nix
		];

	boot = {
		loader = {
			grub = {
				enable = true;
				device = "/dev/sda";
			};
		};
		initrd = {
			checkJournalingFS = false;
		};
	};

	virtualisation.virtualbox.guest.enable = true;
	#fileSystems."/virtualboxshare" = {
	#	fsType = "vboxfs";
	#	device = "Documents";
	#	options = ["rw"];
	#}
	networking.proxy = {
		default = "http://user:password@proxy-sgt.si.socgen:8080";
		noProxy = ".groupe.credit-du-nord.fr,.im.socgen.com,.reuters.net,.session.rservices.com,206.190.125.83,206.190.125.82,206.190.125.81,155.195.47.56,155.195.47.45,155.195.47.44,fxtrades-dl.currenex.net,fxtrades-ts.currenex.net,fxtrades.currenex.net,10.236.249.*,184...*,223...*,autodiscover.*,mail.socgen.com,192...*,127.0.0.1,.socgen,hauthsgt6.socgen.com:9443,authsgt.socgen.com:9443,hauthsgt.socgen.com:9443,175.*,176...*,.netinary.net,.cdn,111.56..*,111.64..*,.hotspot.hub-one.net,.mobility.eur.socgen.com,.extranet.thomsonreuters.biz,.cp.thomsonreuters.net,.adagesg.com,.members.equilend.com,cgacitrix.cga.fr,.sgwifi.btfrance.fr,.sgwifiportal.btfrance.com,.netinary.com,csgs2e.s2e-net.com,d-.socgen.com,.tedi.tessi.fr,.mone.transactis.fr,*nweg.oracleoutsourcing.com,.newedge.ext,.newedge.int,phoenix-london.newedge.com,eu-nomad.newedge.com,ldn-token.newedge.com,m.horizon.vmware.com,*vaservices.socgen.com,.impact.spsfi.broadridge.com,.remoteaccess.sgcib.com,uatpulse.newedge.com,newdevpulse.newedge.com,newuatpulse.newedge.com,199.26.17.92,localhost";
	};
}
