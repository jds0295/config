{ inputs, self, pkgs, lib, config, ... }:
let
  user = "james";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users."${user}" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "James";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  home-manager = {
    backupFileExtension = "bkp";
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs user self; };
    users."${user}" = import ../home/${user};
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # services.getty.autologinUser = "${user}";
}
