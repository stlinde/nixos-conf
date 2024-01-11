{ lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "Roboto Mono";
    theme = "Tokyo Night";
    settings = {
      window_padding_width = 10;
      window_padding_height = 10;
    };
  };
}
