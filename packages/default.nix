{ pkgs, self, ... }@inputs:
{
  remarkable = import ./remarkable.nix inputs;
  install-script = import ./install-script.nix inputs;
}
