{ inputs, pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./user.nix
    # ./impermanence.nix
    # ./stylix.nix
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    corepack
    displaylink 
    fastfetch
    gcc
    git
    go
    input-leap
    neovim
    nodejs_22
    ntfs3g # read ntfs formatted drives
    openjdk21
    python3
    pywal
    starship
    thefuck
    tmux
    unzip
    usbutils # was to check the status of attached usb devices
    vim
    yarn
    # xdg-desktop-portal ## for input leap
    # xdg-desktop-portal-gtk ## for input leap
    xdg-desktop-portal-hyprland ## for input leap
    # xdg-desktop-portal-wlr ## for input leap
  ];

  environment.variables = {
    JAVA_HOME = "${pkgs.openjdk21}";
    GOROOT = "${pkgs.go}";
    GOPATH = "$HOME/go";
    PATH = [ "$HOME/go/bin" ];
  };
}
