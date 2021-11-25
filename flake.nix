{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      {
	nixosConfigurations.potato = nixpkgs.lib.nixosSystem {
	  inherit system pkgs;

	  # Arguments to p[ass to all modules.
	  specialArgs = { inherit system inputs; };

	  modules =
	    [ ./hosts/potato/configuration.nix
	      ./users/weiwen.nix
	      ./features/locale.nix
	      ./features/sway.nix
	      ./features/fonts.nix
	      ./features/games.nix

	      home-manager.nixosModules.home-manager {
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.weiwen = import ./home.nix
		  {
		    inherit pkgs;
		  };
	      }
	    ];
	};

        homeConfigurations.potato = cfg: home-manager.lib.homeManagerConfiguration {
          inherit system;
          username = "weiwen";
          homeDirectory = "/home/weiwen";
          configuration = {
            programs.home-manager.enable = true;
            home.username = "weiwen";
            home.homeDirectory = "/home/weiwen";
          };
        };
      };

}
