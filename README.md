# Nixos configuration

## How to use

When installing nixos:

For encryption. Enter the nix-shell:

    nix-shell https://github.com/FaustXVI/nixos-yubikey-luks/archive/master.tar.gz

Use the `encrypt.sh /path/to/partition nixos /path/to/boot`

Don't forget you can access the nix installation manual by pressing ALT+F8 

- follow the [nix installation manual](https://nixos.org/nixos/manual/index.html#sec-installation) until *step 10*
- use `nix-env -i git` to get git in the shell
- clone this repository in `/etc/nixos`
- link `configuration.nix` to a known machine or create a new one
- run `nixos-generate-configuration` to have the
  `hardware-configuration.nix` generated.
- continue the [nix installation manual](https://nixos.org/nixos/manual/index.html#sec-installation)
