{ mylib, pkgs, config, ...}:
{
  config = mylib.mkIfComputerHasPurpose "work"{
    home-manager.users.xadet = {...}: rec {
      home.file.".config/direnv/lib/watson.sh".text = ''
#!/usr/bin/env bash

LOADED_DIR=$(pwd)

declare -A directory_mapping=(
["eo-vent-tools"]="EO-TOOLKIT" 
["eo150-cpu-software"]="EO-150M" 
)

for DIR in "''${!directory_mapping[@]}"
do
    if [[ ''${LOADED_DIR} =~ ^''${HOME}/''${DIR}.* ]]
    then
        ${pkgs.watson}/bin/watson start ''${directory_mapping[$DIR]} +''${DIR} +$(date +%F)
    fi  
done
        '';
      };
    };
}