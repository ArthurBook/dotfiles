{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

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

  outputs =
    { home-manager
    , nix-darwin
    , nix-homebrew
    , nixpkgs-unstable
    , sops-nix
    , nixpkgs
    , ...
    }:
    let
      username = "arthurbook";
      system = "aarch64-darwin";

      pkgs = import nixpkgs { inherit system; };

      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" ];
      };
    in
    {
      darwinConfigurations."workbook" = nix-darwin.lib.darwinSystem {
        inherit system;

        specialArgs = {
          inherit username pkgsUnstable;
        };

        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          ./nix/system/darwin.nix
        ];
      };

      homeConfigurations."macos" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit username pkgsUnstable;
          };

          modules = [
            ./nix/home/common.nix
            ./nix/hosts/macbook.nix
            sops-nix.homeManagerModules.sops
          ];
        };
    };
}
