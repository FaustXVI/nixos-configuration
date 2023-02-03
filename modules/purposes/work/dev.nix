{ mylib, unstable, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    home-manager.users.xadet = {
      home.packages = with unstable; [
        jetbrains.clion
      ];
    };
  };
}
