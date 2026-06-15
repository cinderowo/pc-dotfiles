{
  description = "dotfiles flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
	      elaine = lib.nixosSystem {
	        inherit system;

	        modules = [
	          ./configuration.nix
	          home-manager.nixosModules.home-manager
            {
	            home-manager = {
		            useGlobalPkgs = true;
		            useUserPackages = true;
		            users.elaine = ./hm/home.nix;
		            extraSpecialArgs = { inherit inputs; };
	            };
	          }

	          stylix.nixosModules.stylix
	        ];
	      };
	      iso = nixpkgs.lib.nixosSystem {
	        system = "x86_64-linux";
	        modules = [
	          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
	          ./configuration.nix
	        ];
	      };
      };
    };
}
