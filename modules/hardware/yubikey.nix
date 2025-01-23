{ config, pkgs, lib, ... }:
let
  authFile = pkgs.writeText "u2f_file"
    ''
      xadet:jYYJ1SeXSGwLXVWqcMDEK4yvev7X6CgGkal0HCS2aQm3li2rmmOX1Q389GRs1f3ek5E-IG6VLp03TwtS9N5eIw,045e326f3945e52b176efb487eb03389a322ae86679ff7d48f02994d6813b1d78ccd13c78d732593a4da91c9520fe3696cd4aea7a87846ad13e93613824403bfbf:yKV09NDG-4dRjgPC_aabCrfCJetIn1LA1-v6WECkAQICOvrFr6cWtCO93FP72C6kef0Zzk5XVGO5HNzbuTDj2A,04fce4170449498383d33ae7da3c520a743853b3b27d31403a67e988a9ca68b8d30f27bcefab6f4092d1c9bcff5f9590d50d9f666d1e18333dd0c62e60141d6136:KkTVzBCQuGE7sUgzx7oXyX4baaNkflLHR44gcNBwxDQN/+iPPsh1le3vnRvkEorZ9WGjhg/pk51FWp+5VmCeyQ==,Qkvu0bTmYByEKQ3eAzVgMIuqC8c7zJMfHQxgSlRu3KwPNEfK9MZbUrkApTBGwjDI8RzFtjAMZOh9rLAh16Bp7Q==,es256,+presence:z+fF70trV02I3MhsfkgWfkA9dMAmtnS6ccO5giEHyr+ORo7QVyMFNZO2YbukcCQ92rw981UydBk4/XY9dQB2Nw==,8+8uOvWSsYt6/xP0+ibieKnH75FNg50nWBpwU7auC4kfItxg42BFvKrhXS2zLQ1Jxs/eQefgLqgzAKUgPysO2w==,es256,+presence
    '';
in
{
  config = {
    environment = {
      systemPackages = with pkgs; [
        yubico-piv-tool
        yubikey-personalization
        yubikey-personalization-gui
        yubioath-flutter
      ];
    };
    systemd.services.auto-lock = {
      enable = true;
      description = "Lock screen";
      serviceConfig = {
        User = config.users.users.xadet.name;
        ExecStart = ''${pkgs.hyprland}/bin/hyprctl --instance 0 'dispatch exec hyprlock' '';
      };
    };
    services = {
      pcscd = {
        enable = true;
      };
    };
    security = {
      pam = {
        services.login.u2fAuth = true;
        sshAgentAuth = {
          enable = true;
        };
        u2f = {
          enable = true;
          control = "required";
          settings = {
            authfile = authFile;
            cue = true;
          };
        };
      };
    };
    programs = {
      ssh.startAgent = false;
    };
    services = {
      udev = {
        packages = with pkgs; [ yubikey-personalization libyubikey yubikey-personalization-gui ];
        extraRules = ''
          ACTION=="remove", ENV{KEY}=="?*", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="0407", ENV{ID_VENDOR_ID}=="1050", RUN+="${pkgs.bash}/bin/bash -c 'systemctl --no-block start auto-lock'"
        '';
      };
    };

  };
}
