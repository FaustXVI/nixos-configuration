{ mylib, ... }:

{
  config = mylib.mkIfComputerIs "laptop" {
    programs.light.enable = true;
  };
}
