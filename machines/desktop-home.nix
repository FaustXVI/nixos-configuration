{ config, pkgs, inputs, ... }:

let
  nixos-hardware = inputs.nixos-hardware;
  LG = "HDMI-0";
  Samsung = "DP-3";
in
{
  imports =
    [
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-cpu-amd-pstate
      nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd
      ./desktop-home-hardware.nix
      ../modules
    ];
  xadetComputer = {
    type = "desktop";
    purposes = [ "perso" "gaming" "youtube" "photo" "home-office" ];
  };
  hardware.nvidia.open = false;


  services = {
    xserver = {
      dpi = 96;
      xrandrHeads = [ LG Samsung ];
      windowManager = {
        i3 = {
          extraSessionCommands = ''
            ${pkgs.autorandr}/bin/autorand -c home
          '';
        };
      };
    };
    autorandr = {
      enable = true;
      defaultTarget = "common";
      profiles = {
        "home" = {
          fingerprint = {
            "${LG}" = "00ffffffffffff001e6d6e5a010101010117010380431c78eaca95a6554ea1260f5054a54b80714f818081c0a9c0b3000101010101017e4800e0a0381f4040403a00a52221000018023a801871382d40582c4500a5222100001e000000fc004c4720554c545241574944450a000000fd00384b1e5a18000a202020202020010702031df14a900403221412051f0113230907078301000065030c001000023a801871382d40582c450056512100001e011d8018711c1620582c250056512100009e011d007251d01e206e28550056512100001e8c0ad08a20e02d10103e9600565121000018000000000000000000000000000000000000000000000000000078";
            "${Samsung}" = "00ffffffffffff004c2de8053332564e2f140103801009780aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500a05a0000001e011d007251d01e206e285500a05a0000001e000000fd00324b1f5111000a202020202020000000fc0053796e634d61737465720a2020012902031cf148901f051404131203230907078301000066030c00100080011d8018711c1620582c2500a05a0000009e011d80d0721c1620102c2580a05a0000009e011d00bc52d01e20b8285540a05a0000001e8c0ad090204031200c405500a05a000000188c0ad08a20e02d10103e9600a05a0000001800000000000000000046";
          };
          config = {
            "${LG}" = {
              enable = true;
              primary = true;
              mode = "2560x1080";
              position = "0x0";
            };
            "${Samsung}" = {
              enable = true;
              mode = "1920x1080";
              position = "2560x0";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "21.05";
  time.hardwareClockInLocalTime = true;


}
