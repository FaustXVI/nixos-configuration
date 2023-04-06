{ pkgs, unstable, lib, ... }@args:
let
  buildFirefoxXpiAddon = lib.makeOverridable ({ stdenv ? pkgs.stdenv
                                              , fetchurl ? pkgs.fetchurl
                                              , pname
                                              , version
                                              , addonId
                                              , url
                                              , sha256
                                              , ...
                                              }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      src = fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    });
  adBlockPlus = buildFirefoxXpiAddon rec {
    pname = "adBlock plus";
    version = "3.16.1";
    addonId = "{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4039476/adblock_plus-3.16.1.xpi";
    sha256 = "IQ8IjTv1kWjoO1zyJYYBnZn4DCb+pfzuwAZemMtT8nI=";
  };
in
{
  programs = {
    firefox = {
      enable = true;
      package = unstable.firefox;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        foxyproxy-standard
        adBlockPlus
      ];
      profiles = {
        "perso" = {
          settings = {
            "signon.rememberSignons" = false;
            "browser.startup.page" = 3;
            "media.eme.enabled" = true;
          };
          search = {
            force = true;
            default = "Google";
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };

              "Bing".metaData.hidden = true;
              "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
          };
        };
      };
    };
  };
}
