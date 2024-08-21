{ lib, config, pkgs, ... }:

{

  imports = [
    ./programs
    ./shell
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "matt";
    homeDirectory = "/home/matt";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  home.enableNixpkgsReleaseCheck = false;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.home-manager.enable = true;
  programs.tmux.enable = true;

  # This one is important... I guess
  wayland.windowManager.hyprland = {
    enable = true;
    settings = lib.mkForce (import ./programs/hyprland.nix {
    });
    extraConfig = "
      monitor=,preferred,auto,1
    ";
  };
}
