{ pkgs, lib, ... }:
{
  # foot
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "monospace:size=10";
        letter-spacing = "0";
	      pad = "8x8";
      };
    };
  };
}
