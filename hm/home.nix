{config, pkgs, inputs, ... }:
let 
  terminal = "foot";

in {
  imports = [
    ../stylix.nix
    ./helix.nix
    ./foot.nix
    ./zsh.nix
    ./music.nix
  ];
  
  home = {
    
    stateVersion = "25.11";

    packages = with pkgs; [
      helix
      tidal-hifi
      vesktop
      vlc
      gimp
      libreoffice-fresh

      parted
      p7zip
      unzip
      dconf
      btop
      dust
      usbutils
      pciutils
      git
      ty
      android-tools
      qbittorrent

      # lutris
      protonup-ng
      gamemode
      gamescope
      protontricks
      mcpelauncher-ui-qt
      prismlauncher
    ];
  };

  services.kdeconnect.enable = true;
}
