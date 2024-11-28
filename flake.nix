{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable-pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur = {
      url = "github:nix-community/NUR/master";
    };
    sops = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops, nur, home-manager, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inputNames = builtins.filter (name: name != "self") (builtins.attrNames inputs);
      inputUpdates = builtins.foldl' (acc: input: acc ++ [ "--update-input" (builtins.toString "${input}") ]) [ ] inputNames;
      xadetPackages = import ./packages { inherit pkgs; };
      nixosMachine = configFile: nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit inputs;
          unstable = import inputs.unstable-pkgs { inherit system; config.allowUnfree = true; };
        };
        modules = [
          { nixpkgs.overlays = [ (final: prev: xadetPackages) ]; }
          home-manager.nixosModules.home-manager
          sops.nixosModules.sops
          nur.nixosModules.nur
          "${./.}/machines/${configFile}.nix"
          {
            system = {
              autoUpgrade = {
                enable = true;
                dates = "13:00";
                persistent = true;
                flake = "/etc/nixos/flake.nix#${configFile}";
                flags = [ "--refresh" ] ++ inputUpdates;
              };
            };
          }
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
      devShells."${system}".default = pkgs.mkShell {
        packages = [
          pkgs.sops
          pkgs.age
        ];
        SOPS_AGE_KEY_FILE = "/home/xadet/nixos-configuration/keys/ageKey.txt";
      };
      installIso = (nixpkgs.lib.nixosSystem rec {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./install/iso.nix
        ];
      }).config.system.build.isoImage;
      nixosConfigurations = builtins.foldl' (set: name: set // { "${name}" = nixosMachine "${name}"; }) { } [
        "desktop-home"
        "eove"
      ];
    };
}
