{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      plugins = with pkgs; [
        {
          name = "z";
          src = fetchFromGitHub {
            owner = "jethrokuan";
            repo = "z";
            rev = "5f6c716b49ae24a5b36df18a6eceb7609d3ae81d";
            sha256 = "0kykhan9rdzy8anif5jp1iv3djrakhwk2arll3k93vaxm3np0gfm";
          };
        }

        {
          name = "fzf";
          src = fetchFromGitHub {
            owner = "jethrokuan";
            repo = "fzf";
            rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
            sha256 = "28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
          };
        }

        {
          name = "bangbang";
          src = fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-bang-bang";
            rev = "816c66df34e1cb94a476fa6418d46206ef84e8d3";
            sha256 = "35xXBWCciXl4jJrFUUN5NhnHdzk6+gAxetPxXCv4pDc=";
          };
        }

        #{
        #  name = "bobthefish";
        #  src = fetchFromGitHub {
        #    owner = "oh-my-fish";
        #    repo = "theme-bobthefish";
        #    rev = "2dcfcab653ae69ae95ab57217fe64c97ae05d8de";
        #    sha256 = "jBbm0wTNZ7jSoGFxRkTz96QHpc5ViAw9RGsRBkCQEIU=";
        #  };
        #}
      ];
    };
  };
}
