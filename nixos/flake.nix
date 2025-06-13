{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # impermanence.url = "github:nix-community/impermanence";
    # disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    # stylix.url = "github:danth/stylix";
    # ags.url = "github:aylur/ags";
    # spicetify-nix.url = "github:Gerg-L/spicetify-nix"; # spotify themeing
    # astal.url = "github:aylur/astal";
    # nur.url = "github:nix-community/NUR";
    dotfiles = {
      url = "github:jds0295/config";
      flake = false;
    };
    hardened-firefox = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux";
      inherit nixpkgs;
    in
    {
      packages = nixpkgs.legacyPackages.${system};
      nixosConfigurations.hollow = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/phantom
        ];
      };
    };
}
