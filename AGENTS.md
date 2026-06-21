# AGENTS.md

## Architecture

- **Flake root**: `flake.nix` — discovers machines by scanning `machines/*.nix` (any `.nix` file becomes a flake output)
- **Machine config**: `machines/<name>.nix` — declares `xadetComputer.type` (`laptop` | `desktop`) and `xadetComputer.purposes`
- **Module composition**: `modules/default.nix` auto-imports all subdirs/files via `importAllFilteredWith`; same pattern in `modules/purposes/`, `modules/hardware/`, `modules/system/`
- **Home-manager**: configs in `modules/system/home-manager/`, per-user files: `xad.nix`, `root.nix`
- **Purposes**: composable feature sets — create `modules/purposes/<name>/default.nix` and list in a machine's `purposes` array
- **Hardware detection**: `nixos-facter-modules` auto-detects hardware via `facter.reportPath` JSON. Disk device auto-detected from facter report; override by passing `device` explicitly.

## Commands

```bash
# Build and switch a machine (requires sudo)
sudo nixos-rebuild switch --flake .#<machine-name>

# Build only (no sudo needed)
nixos-rebuild build --flake .#<machine-name>

# List available machines
nix flake show .

# Enter dev shell (sops + age)
nix develop --flake .
```

> **Agents cannot use sudo.** Use `nixos-rebuild build` to verify configurations without switching.

## Secrets

- SOPS config: `.sops.yaml` — age key `age149suhqjf8zk8phwuvh7lztw79qxmrajdp5uqfhtrd6p8wnss0sssu2qs58`
- Age key: `keys/ageKey.txt` (gitignored, GPG-decrypted at `keys/ageKey.txt.gpg`)
- Dev shell sets `SOPS_AGE_KEY_FILE` automatically via shellHook
- Encrypted files: `secrets/*` + `modules/purposes/*/secrets/*` (nested secrets not covered by `.sops.yaml` `path_regex`, encrypt manually)
- To edit a secret: `sops <file>` (from `nix develop`)

## Machine-specific notes

- **eove**: laptop, TPM + lanzaboote (UEFI secure boot), Hyprland, purposes: work/home-office/gaming/3dPrinting
- **cnc**: laptop, GNOME (Hyprland/greetd forced off), purposes: cnc
- **desktop-home**: desktop, ROCm GPU (pkgs/overlay), Hyprland, Sunshine, purposes: perso/gaming/youtube/photo/home-office/3dPrinting/llm
- All machines: LUKS + disko (GPT + ESP + encrypted swap + ext4 root), stateVersion `24.11`
- `hardware-configuration.nix` and `configuration.nix` are gitignored

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
- `nixpkgs.config.allowUnfree = true` in unstable pkgs import; `rocmSupport = true` in pkgs import
- `nixos-26.05` branch locked via flake.lock
