{ pkgs, inputs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    sassc
    (python311.withPackages (p: [ p.python-pam ]))
    pkgs.libdbusmenu-gtk3
  ];

  programs.ags = {
    enable = true;
    configDir = ../ags;
    extraPackages = with pkgs; [
      libgtop
      libsoup_3
    ];
  };
}
