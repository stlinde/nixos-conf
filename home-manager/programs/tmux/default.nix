{ lib, pkgs, ... }:
let
  tmuxConf = lib.readFile ./tmux.conf;
in
{
  programs.tmux = {
    enable = true;
    extraConfig = tmuxConf;
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
  };
}
