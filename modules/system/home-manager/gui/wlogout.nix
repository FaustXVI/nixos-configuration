{ pkgs, lib, config, ... }:
{
  programs.wlogout = {
    enable = true;
  };
  catppuccin.wlogout.extraStyle = ''
    @import "${pkgs.inputs.catppuccin.packages.${pkgs.system}.waybar}/${config.catppuccin.flavor}.css";
    button {
        border-radius: 20rem;
        border: 0;
        margin: 1rem;
    }

    button:hover {
        box-shadow: 0 0 0.5rem 0 @sapphire;
    }

    button:focus {
        background-color: @mantle;
    }
    button:focus:hover {
        background-color: @surface0;
    }
    window {
        background: transparent;
    }
        button {
        border-radius: 10px;
        }
        window {
        background: transparent;
        }
  '';
}
