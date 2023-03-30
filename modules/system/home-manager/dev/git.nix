{ lib, config, mylib, ... }@args:

{
  programs = {
    git = {
      enable = true;
      userName = lib.mkDefault "FaustXVI";
      userEmail = lib.mkDefault "1016863+FaustXVI@users.noreply.github.com";
      signing = {
        signByDefault = true;
        key = "98AC52834768871837C022716E983A14A5221EE1";
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
          excludesfile = "~/.gitignore_global";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
