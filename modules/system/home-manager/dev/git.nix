{ lib, config, mylib, ... }@args:

let
  ignore_global_file = ".gitignore_global";
in
{
  home.file."${ignore_global_file}".source = ./gitignore_global;
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = lib.mkDefault "FaustXVI";
          email = lib.mkDefault "1016863+FaustXVI@users.noreply.github.com";
        };
        alias = {
          co = "checkout";
          ci = "commit";
          st = "status";
          br = "branch";
          branch-clean = "!git branch --merged | grep -v main | xargs -n 1 git branch -d";
          next = "!git checkout `git rev-list HEAD..demo-end | tail -1`";
        };
        push = {
          default = "current";
          autoSetupRemote = true;
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
      signing = {
        signByDefault = true;
        key = "D158D40AD633259081FB834628EC14C71D3CFAAF";
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
