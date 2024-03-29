{ config, pkgs, inputs, ... }:

{
  # TODO please change the username & home direcotry to your own
  home.username = "slinde";
  home.homeDirectory = "/home/slinde";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Import configurations
  imports = [
    ./programs/tmux
    ./programs/kitty
    ./dev/cc.nix
    ./gtk-theme.nix
    ./ags.nix
    ./hyprland.nix
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Sebastian Hempel Linde";
    userEmail = "sebastian@hempellinde.com";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    which
    brightnessctl
    hyprpicker
    zig
    gtk4
    gh
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    # nix-output-monitor
  ];

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    history = {
      ignoreAllDups = true;
      save = 10000;
      size = 10000;
      share = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    shellAliases = {
      vi = "nvim";
    };
  };
  
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
