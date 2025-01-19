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
      nixosConfigurations = builtins.foldl' (set: name: set // { "${name}" = nixosMachine "${name}"; })
        {
          hyprtest = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              home-manager.nixosModules.home-manager
              {
                programs.hyprland = {
                  enable = true;
                  withUWSM = true;
                  xwayland.enable = true;
                };
                programs.regreet = {
                  enable = true;

                };
                environment.etc."greetd/hyprland.conf".text = ''
                                      input {
                                        kb_layout = fr
                                        kb_variant = bepo
                                      }
                      exec-once = ${pkgs.lib.getExe pkgs.greetd.regreet}; hyprctl dispatch exit
                      misc {
                      disable_hyprland_logo = true
                      disable_splash_rendering = true
                  #    disable_hyprland_qtutils_check = true
                  }
                '';
                environment.etc."greetd/sway.conf".text = ''
                  exec = ${pkgs.lib.getExe pkgs.greetd.regreet}; ${pkgs.lib.getExe pkgs.sway} exit
                '';
                services.greetd = {
                  enable = true;
                  settings = {
                    #initial_session = {
                    default_session = {
                      command = "${pkgs.lib.getExe pkgs.hyprland} -c /etc/greetd/hyprland.conf";
                      #command = "${pkgs.lib.getExe pkgs.sway} -c /etc/greetd/sway.conf";
                      user = "greeter";
                    };
                  };
                };
                environment.variables = {
                  XKB_DEFAULT_LAYOUT = "fr,fr";
                  XKB_DEFAULT_VARIANT = "bepo,oss";
                  XKB_DEFAULT_OPTIONS = "grp:menu_toggle";
                };
                home-manager.users.test = {
                  home.stateVersion = "24.11";
                  wayland.windowManager.hyprland = {
                    enable = true;
                    extraConfig = ''
                      $terminal = ${pkgs.kitty}/bin/kitty
                      env = XCURSOR_SIZE,24
                      env = HYPRCURSOR_SIZE,24
                      $mainMod = SUPER
                      bind = $mainMod, Q, exec, $terminal
                      bind = $mainMod, M, exit,
                      input {
                        kb_layout = fr
                        kb_variant = bepo
                      }
                    '';
                  };
                };
                services.xserver = {
                  #enable = true;
                  xkb = {
                    layout = "fr,fr";
                    variant = "bepo,oss";
                    options = "grp:menu_toggle";
                  };
                };
                console = {
                  earlySetup = true;
                  useXkbConfig = true;
                };
                users.users.test = {
                  isNormalUser = true;
                  password = "test";
                };
              }
            ];
          };
        }
        targets;
    };
}
