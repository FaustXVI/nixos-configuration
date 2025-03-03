{ lib, config, mylib, ... }@args:

let
  ignore_global_file = ".gitignore_global";
in
{
  home.file."${ignore_global_file}".source = ./gitignore_global;
  programs = {
    git = {
      enable = true;
      userName = lib.mkDefault "FaustXVI";
      userEmail = lib.mkDefault "1016863+FaustXVI@users.noreply.github.com";
      signing = {
        signByDefault = true;
        key = "D158D40AD633259081FB834628EC14C71D3CFAAF";
      };
      aliases = {
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch";
        branch-clean = "!git branch --merged | grep -v main | xargs -n 1 git branch -d";
        next = "!git checkout `git rev-list HEAD..demo-end | tail -1`";
      };
      delta = {
        enable = true;
      };
      extraConfig = {
        push = {
          default = "current";
        };
        pull = {
          rebase = "merges";
        };
        core = {
          excludesfile = "~/${ignore_global_file}";
        };
        init = {
          defaultBranch = "main";
        };
        rerere = {
          enable = true;
        };
      };
    };
  };
}
