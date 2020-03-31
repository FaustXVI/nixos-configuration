{
    programs = {
        git = {
            enable = true;
            userName = "FaustXVI";
            userEmail = "xavier.detant@gmail.com";
            signing = {
                signByDefault = true;
                key = "98AC52834768871837C022716E983A14A5221EE1";
            };
            aliases = {
                co = "checkout";
                ci = "commit";
                st = "status";
                br = "branch";
                branch-clean = "!git branch --merged | grep -v master | xargs -n 1 git branch -d";
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
            };
        };
    };
}
