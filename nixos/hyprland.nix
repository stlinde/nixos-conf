{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  environment.systemPackages = with pkgs.gnome; [
    pkgs.loupe # A simple image viewer application written in GTK4 and Rust 
    adwaita-icon-theme
    nautilus # GNOME File Explorer
    baobab # GNOME Application for Analyzing Disk Usage
    gnome-calendar
    gnome-boxes # GNOME Application to Access Remote or Virtual Systems
    gnome-system-monitor
    gnome-control-center
    gnome-weather
    gnome-calculator
    gnome-clocks
    gnome-software # for flatpak
  ];

  services = {
    gvfs.enable = true; # Virtual Filesystem Library Support
    devmon.enable = true; # SNMP Monitoring
    udisks2.enable = true; # Provides daemon to query and manipulate storage devices
    upower.enable = true; # Interface to enumerate power sources
    power-profiles-daemon.enable = true; # Allows for switching power profiles
    accounts-daemon.enable = true; # Let programs access and manage user account infomration through dbus
    gnome = {
      evolution-data-server.enable = true; # Unified backend for contacts, tasks, and calendar information
      glib-networking.enable = true; # Implements certain GLib networking features not directly implemented in GLib itself
      gnome-keyring.enable = true; # Collection of components in GNOME that store secrets, passwords, etc.
      gnome-online-accounts.enable = true; # Single sign-on framework
    };
  };
}
