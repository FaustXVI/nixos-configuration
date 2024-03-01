{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable-pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR/master";
    };
    sops= {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager= {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops, nur, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { 
        inherit inputs;
        unstable = import inputs.unstable-pkgs {inherit system; config.allowUnfree = true; };
      };
      modules = [
        home-manager.nixosModules.home-manager
        sops.nixosModules.sops
        nur.nixosModules.nur
        ./machines/desktop-home.nix
      ];
    };
  };
}
