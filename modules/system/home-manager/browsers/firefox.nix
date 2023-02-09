{pkgs,unstable,...}:
{
  programs = {
    firefox = {
      enable = true;
      package = unstable.firefox;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        foxyproxy-standard
        ghostery
      ];
      profiles = {
        "perso" = {
          search = {
            default = "Google";
#            engines = {
#              "Nix Packages" = {
#                urls = [{
#                  template = "https://search.nixos.org/packages";
#                  params = [
#                    { name = "type"; value = "packages"; }
#                    { name = "query"; value = "{searchTerms}"; }
#                  ];
#                }];
#
#                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
#                definedAliases = [ "@np" ];
#              };
#
#              "NixOS Wiki" = {
#                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
#                iconUpdateURL = "https://nixos.wiki/favicon.png";
#                updateInterval = 24 * 60 * 60 * 1000; # every day
#                definedAliases = [ "@nw" ];
#              };
#
#              "Bing".metaData.hidden = true;
#              "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
#            };
          };
        };
      };
    };
  };
}
