{ pkgs, self, targets, ... }@inputs:
{
  remarkable = import ./remarkable.nix inputs;
  dedrm = import ./dedrm.nix inputs;
} //
(
  builtins.foldl' (set: target: set // { "install-script-${target}" = import ./install-script.nix (inputs // { inherit target; }); }) { } targets
)
