with import <nixos> { };
pkgs.mkShell {
  packages = with pkgs; [ sops age ];
  SOPS_AGE_KEY_FILE = "${toString ./.}/keys/ageKey.txt";
}
