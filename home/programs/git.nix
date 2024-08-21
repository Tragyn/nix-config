{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "tragyn";
    userEmail = "matt@crate.dev";
    package = pkgs.gitFull;
#    config.credential.helper = "libresecret";
    extraConfig = {
      init.defaultBranch = "master";
    };
    aliases = {
      st = "status";
    };
  };
}
