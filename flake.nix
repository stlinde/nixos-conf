{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Aylur's GTK Shell
    ags.url = "github:Aylur/ags";

    # MoreWaita icon theme
    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };
    
    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Zig
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = inputs@{ nixpkgs, home-manager, hyprland, zig, ... }: {
    nixosConfigurations = {
      # TODO please change the hostname to your own
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix

          # Hyprland
          hyprland.nixosModules.default

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.slinde = import ./home-manager/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}

