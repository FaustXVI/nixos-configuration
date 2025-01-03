{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable-pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
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
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops, nur, home-manager, nixos-hardware, disko,  ... }@inputs:
    let
      system = "x86_64-linux";
      targets = [
        "desktop-home"
        "eove"
      ];
      pkgs = import nixpkgs { inherit system; };
      inputNames = builtins.filter (name: name != "self") (builtins.attrNames inputs);
      inputUpdates = builtins.foldl' (acc: input: acc ++ [ "--update-input" (builtins.toString "${input}") ]) [ ] inputNames;
      xadetPackages = import ./packages { inherit pkgs self disko system targets; };
      nixosMachine = configFile: nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit inputs;
          unstable = import inputs.unstable-pkgs { inherit system; config.allowUnfree = true; };
        };
        modules = [
          { nixpkgs.overlays = [ (final: prev: xadetPackages) ]; }
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          sops.nixosModules.sops
          nur.modules.nixos.default
          nur.legacyPackages."${system}".repos.iopq.modules.xraya
          inputs.nixos-facter-modules.nixosModules.facter
          "${./.}/machines/${configFile}.nix"
          ./modules
          {
            system = {
              autoUpgrade = {
                enable = true;
                dates = "13:00";
                persistent = true;
                flake = "/home/xadet/nixos-configuration/flake.nix#${configFile}";
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
        shellHook = ''
          export SOPS_AGE_KEY_FILE="''$(pwd)/keys/ageKey.txt";
        '';
      };
      installIso = import ./install/iso.nix (inputs // { inherit system pkgs targets; });
      testInstallIso = import ./install/testIso.nix { inherit pkgs self; };
      nixosConfigurations = builtins.foldl' (set: name: set // { "${name}" = nixosMachine "${name}"; }) { } targets;
    };
}
