{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.hyprpanel.overlay.x86_64-linux
  ];
}
