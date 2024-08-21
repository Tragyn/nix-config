{
  description = "Your new nix config";

  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprpanel /6c8615c
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel/6c8615c";
    };

    # hyprland
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    }; 

    # Pretty spotify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixOS CLI
    nixos-cli = {
      url = "github:water-sucks/nixos";
    };

    stylix = {
      url = "github:danth/stylix";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    hyprpanel,
    spicetify-nix,
    stylix,
    nixos-cli,
    ...
  }: {
    nixosConfigurations = {
      crate-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	      specialArgs = {
	        inherit inputs;
        };
        modules = [
          ./hosts/crate-laptop
	        ./overlays
          stylix.nixosModules.stylix
	  nixos-cli.nixosModules.nixos-cli
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
	            inherit inputs;
            };
            home-manager.users.matt = import ./home;
          }
        ];
      };

      crate-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };  
        modules = [
          ./hosts/crate-desktop
	        ./overlays
          stylix.nixosModules.stylix
          nixos-cli.nixosModules.nixos-cli
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
	            inherit inputs;
            };
            home-manager.users.matt = import ./home;
          }
        ];
      };
    };
  };
}
