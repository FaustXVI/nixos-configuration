# Nixos configuration


## How to use

When installing nixos:

Don't forget you can access the nix installation manual by pressing ALT+F8 

- follow the [nix installation manual](https://nixos.org/nixos/manual/index.html#sec-installation) until *step 10*
- use `nix-env -p git` to get git in the shell
- clone this repository in `/etc/nixos`
- run `nixos-generate-configuration` to have the
  `hardware-configuration.nix` generated.
- continue the [nix installation manual](https://nixos.org/nixos/manual/index.html#sec-installation)
