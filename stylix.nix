{ pkgs, config, ... }:
{
  stylix.enable = true;

  stylix = {
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    image = ./hm/wallpapers/point-overhead.jpg;

    targets.gtk.enable = true;
  };
}
