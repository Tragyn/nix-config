{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      ls = "eza -l";
      garbage = "nix-collect-garbage";
      garbages = "sudo nix-collect-garbage";
      garbaged = "nix-collect-garbage -d";
      garbagesd = "nix-collect-garbage -d";
      cheat = "echo 'Ctrl+T,C - Rename tab'; echo 'Ctrl+B,C - New Tab'; echo 'Ctrl+B, K - Up Pane'; echo 'Ctrl+B, J - Down Pane'";
    };
  };
}
