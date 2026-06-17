# AGENTS.md

## Architecture

- **NixOS flake** (`flake.nix`) — single flake producing `nixosConfigurations.<machine>`, packages, and an install ISO app.
- **Machines**: `desktop-home.nix` (desktop), `cnc.nix` (laptop, GNOME), `eove.nix` (laptop, Hyprland + lzaboote). Add a `.nix` file to `machines/` to register a new machine.
- **Modules**: `modules/system/` (shared system config), `modules/hardware/` (hardware-specific), `modules/purposes/` (feature sets loaded dynamically via `xadetComputer.purposes`). Each purpose is a directory; new purposes are new directories.
- **Home-manager**: `modules/system/home-manager/` — per-user config. Users `xadet` and `jjdtt` defined in `users.nix`.
- **Packages**: `packages/` — custom derivations + per-machine `install-script-<target>` derivations.

## Key commands

```
nixos-rebuild switch --flake .#<machine>     # apply config to target
nixos-rebuild switch --flake .#<machine> --use-remote-ssh  # remote build
nix flake update                              # update all flake inputs
nix build .#nixosConfigurations.<machine>.config.system.build.toplevel  # build without switching
nix run .#create-install-usb /dev/sdX         # create bootable install USB
```

> **Important**: `nixos-rebuild` must be run as **root** (e.g. via `sudo`), never as a regular user. Agents should **never** use `sudo` — always ask the user to run privileged commands themselves.

## SOPS / secrets

- Age key: `keys/ageKey.txt` (gitignored). Dev shell provides `sops` + `age`: `nix develop`.
- SOPS config: `.sops.yaml` — all paths matching `secrets/.*` encrypted with the listed age public key.
- To edit a secret: `sops secrets/<file>.yaml` (or `.txt`). The file is decrypted in-place.
- `neededForUsers = true` on a secret means it's available before user creation (used for `hashedPasswordFile`).

## Machine-specific notes

- **cnc**: Uses GNOME (Hyprland/greetd forced off). French locale (`fr_FR.UTF-8`). Keyboard: fr/oss + fr/bepo.
- **eove**: Uses systemd-boot + lzaboote (secure boot). TPM-based LUKS unlock.
- **desktop-home**: Uses GRUB (no lzaboote). ROCm support enabled. Sunshine (gamestream) enabled.
- All machines use `luks-interactive-login.nix` from `machines/common/`. Disk device is auto-detected via `facter` on cnc/eove, hardcoded on desktop-home.

## Development conventions

- `modules/utils.nix` provides `importAllFilteredWith` / `importAllWith` — modules auto-import sibling `.nix` files and `default.nix` subdirs. Do not add files that should be excluded to the auto-import path without filtering.
- `xadetComputer.type` is `"laptop"` or `"desktop"`. `xadetComputer.purposes` is a list of purpose directory names. Use `mylib.mkIfComputerIs` / `mylib.mkIfComputerHasPurpose` for conditional config.
- `nixpkgs` pinned to `nixos-26.05`; `unstable-pkgs` available as `pkgs.unstable`.
- `system.stateVersion = "24.11"` on all machines.
- Keyboard layout: `fr,fr` with `oss,bepo` variants, menu-toggle to switch.
