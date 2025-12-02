{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
  };

  outputs = { nixpkgs, nix-darwin, home-manager, sops-nix, nix-homebrew, ... }:
    let
      # Configuration variables
      username = "arthurbook";
      system = "aarch64-darwin";
    in
    {
      # nix-darwin system configuration (system-level only)
      darwinConfigurations."workbook" = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit username; };
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          ./nix/system/darwin.nix
        ];
      };

      # Standalone home-manager configuration (kept for backwards compatibility)
      homeConfigurations."macos" =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = { inherit username; };

          modules = [
            ./nix/home/common.nix
            ./nix/hosts/macbook.nix
            sops-nix.homeManagerModules.sops
          ];
        };
    };
}
