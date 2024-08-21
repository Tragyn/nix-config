# DOCS: https://zellij.dev/documentation
{ pkgs, ... }: {
  programs.zellij.enable = true;
  xdg.configFile = {
    "zellij/plugins/zjstatus.wasm".source = pkgs.fetchurl {
      url = "https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm";
      sha256 = "2204df4a5db811aa7ed3385f8b04ef99d572fddaf23f17c417b2e154d5577be5";
    };
    "zellij/plugins/zellij_forgot.wasm".source = pkgs.fetchurl {
      url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.0/zellij_forgot.wasm";
      sha256 = "1hzdvyswi6gh4ngxnplay69w1n8wlk17yflfpwfhv6mdn0gcmlsr";
    };
    "zellij/plugins/zellij-datetime.wasm".source = pkgs.fetchurl {
      url = "https://github.com/h1romas4/zellij-datetime/releases/download/v0.20.0/zellij-datetime.wasm";
      sha256 = "757c8d30f32359d64f61d21a9fd508c65b49aa737b5140c0384f3906183d1993";
    };

    "zellij/config.kdl".text = import ./config.nix;
    "zellij/layouts/default.kdl".text = import ./layout.nix;
  };
}
