{ pkgs, lib, inputs, ... }:
let
  username = "matt";
in {

  # ============================= User related =============================
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIItETI5nQ1tNxHQ7S7dpDodTU1aT6cPe66+jeS3el9Ac matt@crate-laptop"
    ];
    shell = pkgs.fish;
  };

  # Programs

  programs.ssh.startAgent = true;
  programs.dconf.enable = true;
  programs.sway.enable = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;

  # Stylix
  stylix = {
    enable = true;
    polarity = "dark";
    fonts.sizes = {
      applications = 10;
    };
    # dracula, nord, ayu-mirage, da-one-ocean, harmonic16-dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";
    image = /home/${username}/nix-config/wallpaper.jpg;
  };

  # Optimise store
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    trusted-users = [username];
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    builders-use-substitutes = true;
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  
  fonts = {
    packages = with pkgs; [
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.hyprland
    pkgs.cargo
    pkgs.rustc
    pkgs.ncurses
    pkgs.vim
    pkgs.wget
    pkgs.curl
    pkgs.git
    pkgs.sysstat
    pkgs.lm_sensors # for `sensors` command
    pkgs.scrot
    pkgs.neofetch
    pkgs.xfce.thunar
    pkgs.nnn # terminal file manager
    pkgs.fish
    pkgs.pamixer
    pkgs.whois
    pkgs.swaybg
    pkgs.busybox
    pkgs.fzf
    pkgs.slurp
    pkgs.grim
    pkgs.firefox-beta-bin
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-wlr
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
    })
  ];

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  security = {
    polkit.enable = true;
  };

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
    nixos-cli.enable = true;
    printing.enable = false;    
    power-profiles-daemon.enable = true;
    dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;
    blueman.enable = true;
    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = false; # disable password login
      };
      openFirewall = true;
    };
  };
}
