{ lib, config, mylib, ... }@args:

{
  home.file.".config/nono/profiles/opencode.json".text = ''
{
  "''$schema": "https://opencode.ai/config.json",
  "extends": [
    "nolabs-ai/opencode"
  ],
  "meta": {
    "name": "opencode",
    "version": "",
    "description": null,
    "author": null
  },
  "security": {
    "signal_mode": null,
    "process_info_mode": null,
    "ipc_mode": null,
    "capability_elevation": false,
    "approval_backends": {},
    "approval_defaults": null,
    "wsl2_proxy_policy": null
  },
  "groups": {
    "include": [],
    "exclude": []
  },
  "commands": {
    "allow": [],
    "deny": []
  },
  "filesystem": {
    "allow": [
        "/tmp",
        "~/.cargo"
    ],
    "read": [
      "~/.config/nono",
      "${config.sops.templates."github-token_git.conf".path}",
      "${config.sops.templates."nix-github-token.conf".path}"
    ],
    "write": [],
    "allow_file": [],
    "read_file": [
      "/run/secrets/scaleway.token",
      "/proc/sys/vm/mmap_min_addr"
    ],
    "write_file": [],
    "unix_socket": [],
    "unix_socket_bind": [],
    "unix_socket_dir": [],
    "unix_socket_dir_bind": [],
    "unix_socket_subtree": [],
    "unix_socket_subtree_bind": [],
    "deny": [],
    "bypass_protection": [],
    "suppress_save_prompt": [
      "/",
      "/home",
      "~/",
      "/sys/kernel/debug/tracing"
    ]
  },
  "network": {
    "block": false,
    "allow_http2": false,
    "allow_domain": [],
    "deny_domain": [],
    "credentials": [],
    "open_port": [],
    "open_port_range": [],
    "listen_port": [],
    "listen_port_range": [],
    "connect_port": [],
    "no_proxy": [],
    "custom_credentials": {},
    "tls_intercept": null,
    "upstream_proxy": null,
    "upstream_bypass": []
  },
  "diagnostics": {
    "suppress_system_services": []
  },
  "linux": {
    "af_unix_mediation": null,
    "sandbox_policy": null
  },
  "env_credentials": {},
  "credential_capture": {},
  "credential_providers": {},
  "credential_routes": [],
  "workdir": {
    "access": "readwrite"
  },
  "hooks": {},
  "session_hooks": {},
  "rollback": {
    "exclude_patterns": [],
    "exclude_globs": []
  },
  "interactive": false,
  "skipdirs": [],
  "packs": [],
  "command_args": [],
  "unsafe_macos_seatbelt_rules": []
}
  '';
}
