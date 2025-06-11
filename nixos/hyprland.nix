{ pkgs, ... }:
{
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = with pkgs; [
    kitty # required for the default Hyprland config
    kdePackages.dolphin
    waybar
    wofi
  ];

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
