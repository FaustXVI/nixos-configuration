# AGENTS.md

## Architecture

- **Flake root**: `flake.nix` — discovers machines by scanning `machines/*.nix` (any `.nix` file becomes a flake output)
- **Machine config**: `machines/<name>.nix` — declares `xadetComputer.type` (`laptop` | `desktop`) and `xadetComputer.purposes` (list from `modules/purposes/*/default.nix` dirs)
- **Module composition**: `modules/default.nix` auto-imports all subdirs/files via `importAllFilteredWith`; same pattern in `modules/purposes/`, `modules/hardware/`, `modules/system/`
- **Home-manager**: configs in `modules/system/home-manager/`, per-user files: `xad.nix`, `root.nix`
- **Purposes**: composable feature sets (e.g. `gaming`, `cnc`, `3dPrinting`, `work`, `youtube`). Add a purpose by creating `modules/purposes/<name>/default.nix` and listing it in a machine's `purposes` array.
- **Hardware detection**: `nixos-facter-modules` auto-detects hardware via `facter.reportPath` JSON (e.g. `facter-eove.json`). Disk device is auto-detected from facter report; override by passing `device` explicitly.

## Commands

```bash
# Build and switch a machine (requires sudo)
sudo nixos-rebuild switch --flake .#<machine-name>

# Build a home-manager config for a machine (requires sudo)
sudo home-manager switch --flake .#<machine-name>

# Dry run / check (no sudo needed)
nixos-rebuild build --flake .#<machine-name>

# Enter dev shell (sops + age)
nix develop --flake .

# Create install USB
nix run .#create-install-usb /dev/sdX

# List available machines (flake outputs)
nix flake show .
```

> **Agents cannot use sudo.** Use `nixos-rebuild build` (dry run) to verify configurations without switching.

## Secrets

- SOPS config: `.sops.yaml` — all `secrets/*` encrypted with age key `age149suhqjf8zk8phwuvh7lztw79qxmrajdp5uqfhtrd6p8wnss0sssu2qs58`
- Age key: `keys/ageKey.txt` (gitignored, GPG-decrypted version at `keys/ageKey.txt.gpg`)
- Dev shell sets `SOPS_AGE_KEY_FILE` automatically
- To edit a secret: `sops <secrets-file>`

## Machine-specific notes

- **eove**: laptop, TPM + lanzaboote (UEFI secure boot), Hyprland, purposes: work/home-office/gaming/3dPrinting
- **cnc**: laptop, GNOME (Hyprland/greetd forced off), purposes: cnc
- **desktop-home**: desktop, ROCm GPU, Hyprland, purposes: perso/gaming/youtube/photo/home-office/3dPrinting/llm
- All machines use `luks-interactive-login.nix` with disko for disk layout (GPT + ESP + encrypted swap + LUKS/ext4 root)
- `hardware-configuration.nix` and `configuration.nix` are gitignored (generated per-host)

## Adding a new machine

1. Create `machines/<name>.nix` with `xadetComputer` declaration and `facter.reportPath`
2. Import `./common/luks-interactive-login.nix` with the disk device
3. Set `system.stateVersion`
4. Add machine-specific overlays/configs as needed

## Adding a new purpose

1. Create `modules/purposes/<name>/default.nix` that imports its submodules
2. Add any machine to the purpose via `purposes = [ ... "<name>" ... ]`

## Style conventions

- `mkForce` used to override defaults from other modules (common pattern)
- `mylib.computerIs` / `mylib.computerHasPurpose` for conditional config
- `nixpkgs.config.allowUnfree = true` set in unstable pkgs import
- `nixpkgs.config.rocmSupport = true` set in pkgs import
