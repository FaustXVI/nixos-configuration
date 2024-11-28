{ pkgs, ... }:
{
  remarkable = import ./remarkable.nix { inherit pkgs; };
}
