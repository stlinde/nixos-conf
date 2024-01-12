{ pkgs, inputs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    # systemd.enable = true;
    xwayland.enable = true;

    settings = {
      exec-once = [
        "ags -b hypr"
        "swww init"
        "swww img ~/.utils/Hyprland-Dotfs/wallpapers/Fantasy-Landscape.png" 
        "hyprctl setcursor Qogir 24"
      ];
      monitor = [
        "eDP-1,1920x1080@60,auto,1"
      ];
      general = {
        layout = "dwindle";
        resize_on_border = true;
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
      };
      input = {
        kb_layout = "dk";
        kb_options = "ctrl:nocaps";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
        };
        sensitivity = 0;
      };
      binds = {
        allow_workspace_cycles = true;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
        workspace_swipe_numbered = true;
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      master = {
        new_is_master = false;
      };
      misc = {
        force_default_wallpaper = 0;
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      decoration = {
        rounding = 10;
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
        };
      };
      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
        (f "org.gnome.Calculator")
          (f "org.gnome.Nautilus")
          (f "pavucontrol")
          (f "nm-connection-editor")
          (f "blueberry.py")
          (f "org.gnome.Settings")
          (f "org.gnome.design.Palette")
          (f "Color Picker")
          (f "xdg-desktop-portal")
          (f "xdg-desktop-portal-gnome")
          (f "transmission-gtk")
          (f "com.github.Aylur.ags")
          "workspace 7, title:Spotify"
      ];
      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        e = "exec, ags -b hypr";
        arr = [1 2 3 4 5 6 7 8 9];
      in [
        "CTRL SHIFT, R,  ${e} quit; ags -b hypr"
        "SUPER, R,       ${e} -t applauncher"
        ", XF86PowerOff, ${e} -t powermenu"
        "SUPER, Tab,     ${e} -t overview"
        ", XF86Launch4,  ${e} -r 'recorder.start()'"
        ",Print,         ${e} -r 'recorder.screenshot()'"
        "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"
        "SUPER, Return, exec, kitty" # xterm is a symlink, not actually xterm
        "SUPER, W, exec, firefox"
        "SUPER, E, exec, wezterm -e lf"

        "ALT, Tab, focuscurrentorlast"
        "CTRL ALT, Delete, exit"
        "SUPER, Q, killactive"
        "SUPER, F, togglefloating"
        "SUPER, G, fullscreen"
        "SUPER, O, fakefullscreen"
        "SUPER, P, togglesplit"

        (mvfocus "k" "u")
        (mvfocus "j" "d")
        (mvfocus "l" "r")
        (mvfocus "h" "l")
        (ws "left" "e-1")
        (ws "right" "e+1")
        (mvtows "left" "e-1")
        (mvtows "right" "e+1")
        (resizeactive "k" "0 -20")
        (resizeactive "j" "0 20")
        (resizeactive "l" "20 0")
        (resizeactive "h" "-20 0")
        (mvactive "k" "0 -20")
        (mvactive "j" "0 20")
        (mvactive "l" "20 0")
        (mvactive "h" "-20 0")
      ]
      ++ (map (i: ws (toString i) (toString i)) arr)
      ++ (map (i: mvtows (toString i) (toString i)) arr);
      bindle = let e = "exec, ags -b hypr -r"; in [
        ",XF86MonBrightnessUp,   ${e} 'brightness.screen += 0.05; indicator.display()'"
          ",XF86MonBrightnessDown, ${e} 'brightness.screen -= 0.05; indicator.display()'"
          ",XF86KbdBrightnessUp,   ${e} 'brightness.kbd++; indicator.kbd()'"
          ",XF86KbdBrightnessDown, ${e} 'brightness.kbd--; indicator.kbd()'"
          ",XF86AudioRaiseVolume,  ${e} 'audio.speaker.volume += 0.05; indicator.speaker()'"
          ",XF86AudioLowerVolume,  ${e} 'audio.speaker.volume -= 0.05; indicator.speaker()'"
      ];

      bindl = let e = "exec, ags -b hypr -r"; in [
        ",XF86AudioPlay,    ${e} 'mpris?.playPause()'"
          ",XF86AudioStop,    ${e} 'mpris?.stop()'"
          ",XF86AudioPause,   ${e} 'mpris?.pause()'"
          ",XF86AudioPrev,    ${e} 'mpris?.previous()'"
          ",XF86AudioNext,    ${e} 'mpris?.next()'"
          ",XF86AudioMicMute, ${e} 'audio.microphone.isMuted = !audio.microphone.isMuted'"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
      ];
    };
  };
}
