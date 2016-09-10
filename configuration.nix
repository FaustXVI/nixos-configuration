# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "fr";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    networkmanagerapplet
    git
    vim
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;
  services.xserver.synaptics.tapButtons = true;
  services.xserver.displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
  services.xserver.inputClassSections = [
  ''
    Identifier      "TypeMatrix"
    MatchIsKeyboard "on"
    MatchVendor     "TypeMatrix.com"
    MatchProduct    "USB Keyboard"
    Driver          "evdev"
    Option          "XbkModel"      "tm2030USB"
    Option          "XkbLayout"     "fr"
    Option          "XkbVariant"    "bepo"
  ''
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.xadet = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "changeMe";
  };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";


}
