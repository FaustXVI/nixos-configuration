{ config, pkgs, mylib, ... }:

{
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };
  environment.variables = {
    XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
    XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;
    XKB_DEFAULT_OPTIONS = config.services.xserver.xkb.options;
  };
  services = {
    udev = {
      # extra rules so that I can flash my ergodox
      extraRules = ''
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
      '';
    };
    xserver = {
      autoRepeatDelay = 200;
      xkb = {
        layout = "fr,fr";
        variant = if mylib.computerIs "laptop" then "oss,bepo" else "bepo,oss";
        options = "grp:menu_toggle";
      };
      inputClassSections = [
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
        ''
          Identifier      "Ergodox"
          MatchIsKeyboard "on"
          MatchUSBID	"feed:1307"
          Driver          "evdev"
          Option          "XkbLayout"     "fr"
          Option          "XkbVariant"    "bepo"
        ''
        ''
          Identifier      "Ergodox EZ"
          MatchIsKeyboard "on"
          MatchProduct    "ErgoDox EZ"
          Driver          "evdev"
          Option          "XkbLayout"     "fr"
          Option          "XkbVariant"    "bepo"
        ''
      ];
    };
  };
  #sound.mediaKeys.enable = true;
}
