{ pkgs, mylib, lib, config, ... }@args:
let
  asContext = attr: lib.mkMerge [
    attr
    {
      style = "fg:crust bg:blue";
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
            error_symbol = "[](bg:peach fg:red)[  ](bg:red)[](fg:red)";
            success_symbol = "[ ](bg:peach)[](fg:peach)";
          };
          cmd_duration = {
            format = "[](fg:red bg:blue)[󰥔$duration]($style)[](fg:red bg:blue)";
            style = "fg:crust bg:red";
          };
          conda = {
            symbol = "";
          };
          directory = {
            format = "[$path ]($style)";
            read_only = " ";
            style = "fg:crust bg:mauve";
            truncation_length = 3;
            truncation_symbol = "…/";
          };
          docker_context = {
            format = "[ $symbol $context ]($style) $path";
            style = "fg:crust bg:blue";
            symbol = "";
          };
          format = ''([](fg:blue)$nix_shell$all[](fg:blue))$line_break[](fg:mauve)''${custom.watson}$directory[](fg:mauve bg:peach)$git_branch$git_commit$git_state$git_status$character'';
          git_branch = {
            format = "[ $symbol $branch]($style)";
            style = "fg:crust bg:peach";
            symbol = "";
          };
          git_commit = {
            format = "[  $hash$tag]($style)";
            style = "fg:crust bg:peach";
          };
          git_state = {
            format = "[ \\($state( $progress_current/$progress_total)\\)]($style)";
            style = "fg:crust bg:peach";
          };
          git_status = {
            format = "[( $all_status$ahead_behind)]($style)";
            style = "fg:crust bg:peach";
          };
          hg_branch = {
            symbol = "";
          };
          jobs = {
            format = "[ $symbol( $number) ]($style)";
            style = "fg:crust bg:blue";
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
            style = "fg:crust bg:blue";
            symbol = "";
          };
          palettes = {
            catppuccin_mocha = {
              watson = "#a6e3a1";
            };
          };
          spack = {
            symbol = "🅢";
          };
          username = {
            format = "[](fg:red bg:blue)[ $user]($style)[](fg:red bg:blue)";
            style_root = "fg:crust bg:red";
            style_user = "fg:crust bg:red";
          };
        }
      ];
    };
  };
}
