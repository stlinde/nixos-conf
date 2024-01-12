{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      clang
        bear
        gdb
        cmake
    ];
  };
}
