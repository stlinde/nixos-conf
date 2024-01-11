# SHLinde's NixOS Configuration

## Setup

Do the following to setup the repo as the NixOS config:

``` bash
sudo ln -s ~/nixos-config/ /etc/nixos

# Deploy the flake.nix located at the default location (/etc/nixos)
sudo nixos-rebuild switch
```

Then you can do system rollback using git:

``` bash
cd ~/nixos-config

# Switch to the previous commit
git checkout HEAD^1

# Deploy the flake.nix located in the current directory,
# with the nixosConfiguration's name `nixos`
sudo nixos-rebuild switch --flake .#nixos
```

## Why

## Decisions
