{ config, pkgs, ...}:
{
    programs.opencode = {
        enable = true;
        context = ./AGENTS.md;
    };
}
