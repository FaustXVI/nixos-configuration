{ lib, config, ... }:
with lib;
let
  hasSuffix = suffix: content:
  let
    lenContent = builtins.stringLength content;
    lenSuffix = builtins.stringLength suffix;
  in
  lenContent >= lenSuffix
  && builtins.substring (lenContent - lenSuffix) lenContent content == suffix;

  contains = e: c: lib.any (x: x == e) c;
in rec {
  computerTypes = [ "laptop" "desktop" ];
  purposesTypes = [ "home" "work" "gaming" "youtube" "photo" ];

  filterAttr = f: attrs: 
  let
    names = with builtins; (filter (key: f key (getAttr key attrs)) (attrNames attrs));
  in
    with builtins;
    foldl' (set: name: set // {"${name}" = getAttr name attrs; } ) {} names;

  importsWith = args: paths: map (path: import path args) paths;

  importAllFilteredWith = filter: args: p: let
    path = builtins.toString p;
    isNixFile = name: (filter name) && name != "default.nix" && hasSuffix ".nix" name;
    isNixDir = name: builtins.pathExists "${path}/${name}/default.nix";
    imported = with builtins; attrNames (filterAttr (n: v: 
    (v == "directory" && isNixDir n)
    || isNixFile n
    ) (readDir path));
    pathsToImport = with builtins; map (n: "${path}/${n}") imported;
  in
  importsWith args pathsToImport;

  importAllWith = importAllFilteredWith (n: true);

  computerIs = type: assert assertMsg (contains type computerTypes ) "${type} is not a computer type"; config.xadetComputer.type == type;

  computerHasPurpose = purpose: assert assertMsg (contains purpose purposesTypes ) "${purpose} is not a purposes type";contains purpose config.xadetComputer.purposes;

  mkIfComputerIs = type: mkIf (computerIs type);
  mkIfComputerHasPurpose = purpose: mkIf (computerHasPurpose purpose);
}
