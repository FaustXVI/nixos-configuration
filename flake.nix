{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
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
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops, nur, home-manager, disko, ... }@inputs:
    let
      system = "x86_64-linux";
      targets = [
        "desktop-home"
        "eove"
      ];
      pkgs = import nixpkgs { inherit system; };
      unstable = import inputs.unstable-pkgs { inherit system; config.allowUnfree = true; };
      xadetPackages = import ./packages { inherit pkgs self disko system targets; };
      nixosMachine = configFile: nixpkgs.lib.nixosSystem rec {
        inherit system;
        modules = [
          { nixpkgs.overlays = [ (final: prev: xadetPackages) (final: prev: { inherit unstable; }) ]; }
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          sops.nixosModules.sops
          nur.modules.nixos.default
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
