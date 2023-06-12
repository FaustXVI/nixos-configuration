{ pkgs, mylib, lib, ... }@args:
let
  asContext = attr: lib.mkMerge [
    attr
    {
      style = "bg:context";
    }
  ];
  asLanguage = attr: lib.mkMerge [
    attr
    (asContext {
      format = "[ $symbol ($version) ]($style)";
    })
  ];
  languages = builtins.mapAttrs (_: asLanguage) {
    buf = {
      symbol = "";
    };
    c = {
      symbol = "";
    };
    cmake = {
      symbol = "";
    };
    dart = {
      symbol = "";
    };
    elixir = {
      symbol = "";
    };
    elm = {
      symbol = "";
    };
    golang = {
      symbol = "";
    };
    haskell = {
      symbol = "";
    };
    java = {
      symbol = "";
    };
    julia = {
      symbol = "";
    };
    lua = {
      symbol = "";
    };
    nim = {
      symbol = "";
    };
    nodejs = {
      symbol = "";
    };
    package = {
      symbol = "";
    };
    python = {
      symbol = "";
    };
    rlang = {
      symbol = "ﳒ";
    };
    ruby = {
      symbol = "";
    };
    rust = {
      symbol = "";
    };
    scala = {
      symbol = "";
    };
  };
in
{
  programs = {
    starship = {
      enable = true;
      settings = lib.mkMerge [
        languages
        {
          aws = {
            symbol = " ";
          };
          character = {
            error_symbol = "[](bg:git fg:alert)[  ](bg:alert)[](fg:alert)";
            success_symbol = "[ ](bg:git)[](fg:git)";
          };
          cmd_duration = {
            format = "[](fg:alert bg:context)[󰥔$duration]($style)[](fg:alert bg:context)";
            style = "bg:alert";
          };
          conda = {
            symbol = "";
          };
          directory = {
            format = "[$path ]($style)";
            read_only = " ";
            style = "bg:path";
            truncation_length = 3;
            truncation_symbol = "…/";
          };
          docker_context = {
            format = "[ $symbol $context ]($style) $path";
            style = "bg:context";
            symbol = "";
          };
          format = ''([](fg:context)$nix_shell$all[](fg:context))$line_break[](fg:path)''${custom.watson}$directory[](fg:path bg:git)$git_branch$git_commit$git_state$git_status$character'';
          git_branch = {
            format = "[ $symbol $branch]($style)";
            style = "bg:git";
            symbol = "";
          };
          git_commit = {
            format = "[  $hash$tag]($style)";
            style = "bg:git";
          };
          git_state = {
            format = "[ \\($state( $progress_current/$progress_total)\\)]($style)";
            style = "bg:git";
          };
          git_status = {
            format = "[( $all_status$ahead_behind)]($style bg:git)";
          };
          hg_branch = {
            symbol = "";
          };
          jobs = {
            format = "[ $symbol( $number) ]($style)";
            style = "bg:context";
          };
          memory_usage = {
            symbol = "";
          };
          meson = {
            symbol = "喝";
          };
          nix_shell = {
            format = "[$symbol( $state )]($style)";
            impure_msg = "";
            style = "bg:context";
            symbol = "";
          };
          palette = "xadet";
          palettes = {
            original = {
              alert = "#FC6262";
              context = "#86BBD8";
              git = "#FCA17D";
              path = "#DA627D";
              watson = "#DA627D";
            };
            xadet = {
              alert = "#FC6262";
              context = "#5f8599";
              git = "#bf7b60";
              path = "#bf566d";
              watson = "#398039";
            };
          };
          spack = {
            symbol = "🅢";
          };
          username = {
            format = "[](fg:alert bg:context)[ $user]($style)[](fg:alert bg:context)";
            style_root = "bg:alert";
            style_user = "bg:alert";
          };
        }
      ];
    };
  };
}
