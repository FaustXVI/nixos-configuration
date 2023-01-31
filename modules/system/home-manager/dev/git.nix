{lib, config, ...}@args:

let
  mylib = import ../../../utils.nix args;
in {
    programs = {
        git = {
            enable = true;
            userName = if mylib.computerHasPurpose "work" then "Xavier Detant" else "FaustXVI";
            userEmail = if mylib.computerHasPurpose "work" then "xavier.detant@eove.fr" else "xavier.detant@gmail.com";
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
            extraConfig = {
              push = {
                default = "current";
              };
              pull = {
                rebase = true;
              };
              core = {
                excludesfile = "~/.gitignore_global";
                pager = "cat";
              };
              init = {
                defaultBranch = "main";
              };
            };
        };
    };
}
