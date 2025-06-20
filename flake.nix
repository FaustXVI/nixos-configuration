{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable-pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops, nur, home-manager, disko, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      filterAttr = f: attrs:
        let
          names = with builtins; (filter (key: f key (getAttr key attrs)) (attrNames attrs));
        in
        with builtins;
        foldl' (set: name: set // { "${name}" = getAttr name attrs; }) { } names;
      machine-files = with builtins; attrNames (filterAttr (f: t: t == "regular") (readDir ./machines));
      nix-machine-files = with builtins; filter
        (n:
          let
            len = builtins.stringLength n;
          in
          builtins.substring (len - 4) len n == ".nix")
        machine-files;
      targets = with builtins; map
        (n:
          let
            len = builtins.stringLength n;
          in
          builtins.substring 0 (len - 4) n)
        nix-machine-files;
      pkgs = import nixpkgs { inherit system; };
      unstable = import inputs.unstable-pkgs { inherit system; config.allowUnfree = true; };
      xadetPackages = import ./packages { inherit pkgs self disko system targets; };
      nixosMachine = configFile: nixpkgs.lib.nixosSystem rec {
        inherit system;
        modules = [
          {
            nixpkgs.overlays = [
              (final: prev: xadetPackages)
              (final: prev: { inherit unstable inputs system; })
              (final: prev: {
                candle = prev.candle.overrideAttrs (oldAttrs: rec {
                  version = "1.2b";

                  src = pkgs.fetchFromGitHub {
                    owner = "Denvi";
                    repo = "Candle";
                    rev = "v${version}";
                    sha256 = "sha256-+14ZRFtAo+WzM4v3U3l9uU3xzhzbdM8+iaujhz9dNuY=";
                  };
                  cmakeFlags = [
                    "-DDEFAULT_SETTINGS_LOCATION=ON"
                  ];
                });
              })
            ];
          }
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          sops.nixosModules.sops
          nur.modules.nixos.default
          catppuccin.nixosModules.catppuccin
          nur.legacyPackages."${system}".repos.iopq.modules.xraya
          inputs.nixos-facter-modules.nixosModules.facter
          "${./.}/machines/${configFile}.nix"
          ./modules
          {
            options = {
              usedFlake = pkgs.lib.mkOption {
                type = pkgs.lib.types.str;
                default = "${configFile}";
              };
            };
          }
        ];
      };
    in
    {
      packages."${system}" = xadetPackages;
      apps."${system}" = {
        create-install-usb =
          let
            rootUsbScript = pkgs.writeShellScriptBin "root-iso-to-usb" ''
              set -e
              TARGET_DEVICE="$1"
              ISO_SIZE=$(wc -c "${self.installIso}/iso/${self.installIso.isoName}")
              echo "Going to write $ISO_SIZE bytes to the USB stick at $TARGET_DEVICE"
              ${pkgs.util-linux}/bin/wipefs --all "$TARGET_DEVICE"
              dd if=${self.installIso}/iso/${self.installIso.isoName} of="$TARGET_DEVICE" status=progress
            '';
            usbScript = pkgs.writeShellScriptBin "iso-to-usb" ''
              set -e
              if [ "$#" -ne 1 ]; then
                echo "Usage : $0 /dev/selected_mass_storage" >&2
                echo "with /dev/selected_mass_storage being the raw device (and not a partition) for a USB stick on which to install the vault live image" >&2
                exit -1
              fi
              KEY="$1"
              if [ "$(<''${KEY/dev/sys\/block}/removable)" != "1" ]; then
                echo "Error : $KEY is not removable." >&2
                exit -2
              fi
              read -p "Make sure all partitions on destination device $KEY are unmounted then press enter" answer

              if [[ -n $(${pkgs.util-linux}/bin/lsblk -n -o MOUNTPOINTS $KEY) ]]; then
                echo "Some partitions are still mounted. Please unmount them."
                ${pkgs.util-linux}/bin/lsblk $KEY
                exit -3
              fi

              sudo ${pkgs.lib.getExe rootUsbScript} $KEY
            '';
          in
          {
            type = "app";
            program = "${pkgs.lib.getExe usbScript}";
          };
      };
      devShells."${system}".default = pkgs.mkShell {
        packages = [
          pkgs.sops
          pkgs.age
        ];
        shellHook = ''
          export SOPS_AGE_KEY_FILE="''$(pwd)/keys/ageKey.txt";
        '';
      };
      installIso = import ./install/iso.nix (inputs // { inherit system pkgs targets; });
      testInstallIso = import ./install/testIso.nix { inherit pkgs self; };
      nixosConfigurations = builtins.foldl' (set: name: set // { "${name}" = nixosMachine "${name}"; }) { } targets;
    };
}
