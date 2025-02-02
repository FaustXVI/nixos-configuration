{ config, pkgs, mylib, ... }:
{
    programs.regreet = {
      enable = true;
      extraCss = ''
@import "${pkgs.inputs.catppuccin.packages.${pkgs.system}.waybar}/${config.catppuccin.flavor}.css";
@define-color theme_bg_color @surface2;
@define-color accent @${config.catppuccin.accent};

window {
    background: @base;
}

selection {
    color: @text;
    background: alpha(@overlay2,0.3);
}

frame,
image,
grid {
    border:0;
    color: @text;
}

frame {
    box-shadow: 0 0 0.5rem @accent;
}

button,
entry,
combobox,
combobox entry,
combobox popover,
combobox popover contents,
combobox popover contents modelbutton,
combobox button,
combobox window menu,
input {
    color: @text;
    border-color: @surface0;
    background: @surface0;
}

button:hover,
combobox:hover,
combobox modelbutton:hover{
    border-color: @surface1;
    background: @surface1;
}


button.suggested-action{
    color: @base;
    border-color: @accent;
    background: @accent;
}
button.suggested-action:hover{
    border-color: darker(@accent);
    background: darker(@accent);
}

button.destructive-action{
    color: @base;
    border-color: @red;
    background: @red;
}
button.destructive-action:hover{
    border-color: darker(@red);
    background: darker(@red);
}

infobar,
infobar box {
    border: 0;
    background: @surface0;
    color: @red;
}
      '';
    };
}
