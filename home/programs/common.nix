{ lib, pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.p7zip
    pkgs.ripgrep
    pkgs.libnotify
    pkgs.xdg-utils
    pkgs.fzf
    pkgs.slurp
    pkgs.grim
    pkgs.obsidian
    pkgs.fish
    pkgs.byobu
#    pkgs.spotify
    pkgs.brightnessctl
    pkgs.gnome.gnome-bluetooth
    pkgs.ncdu
    pkgs.libsecret
    pkgs.swaybg
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.nodePackages.pnpm
    pkgs.yarn
    pkgs.vlc pkgs.mpv
    pkgs.zellij
    pkgs.vscode
    pkgs.ncspot
    pkgs.tmux
    pkgs.fuzzel
    pkgs.hyprpanel
    pkgs.firefox-beta-bin
    pkgs.spotify-player
    pkgs.bitwarden
    (pkgs.discord.override {withVencord = true;})
    pkgs.fastfetch
  ];

  # Manage incompatible .configs
  programs.spotify-player.enable = true; xdg.configFile."spotify-player".source = ./dots/spotify-player;
  programs.ncspot.enable = true; xdg.configFile."ncspot/credentials.json".source = ./dots/ncspot/credentials.json;

  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    fuzzel.enable = true;
    vscode.enable = true;
    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    ssh.enable = true;
    aria2.enable = true;
    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };
}
