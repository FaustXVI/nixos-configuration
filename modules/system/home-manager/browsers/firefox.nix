{ pkgs, lib, config, mylib, ... }@args:
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
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    bitwarden
    foxyproxy-standard
    adblocker-ultimate
    screenshot-capture-annotate
    # https://github.com/catppuccin/firefox
    firefox-color
    # https://github.com/catppuccin/userstyles/tree/main/styles/gmail
    stylus
  ];
  settings = {
    "signon.rememberSignons" = false;
    "browser.startup.page" = 3;
    "media.eme.enabled" = true;
    "extensions.formautofill.creditCards.enabled" = false;
    "accessibility.typeaheadfind" = true;
    "browser.download.useDownloadDir" = false;
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

      "NixOS options" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
      };

      "Home manager options" = {
        urls = [{
          template = "https://home-manager-options.extranix.com/";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@hm" ];
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
in
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.unstable.firefox-bin;
      profiles = lib.mkMerge [
        {
          "perso" = {
            id = 0;
            inherit settings search extensions;
          };
        }
        (mylib.mkIfComputerHasPurpose "work"
          {
            "perso".isDefault = false;
            "eove" = {
              id = 1;
              isDefault = true;
              inherit search settings extensions;
            };
          })
      ];
    };
  };
}
