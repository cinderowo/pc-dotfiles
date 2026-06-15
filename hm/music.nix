{config, pkgs, ... }:
let
  profilePath = "~/.nix-profile";
  homePath    = "/home/elaine";
  lv2Path     = "${profilePath}/lib/lv2";
  vstPath     = "${profilePath}/lib/vst:${homePath}/.vst:${homePath}/.vst/yabridge";
  vst3Path    = "${profilePath}/lib/vst3";
  ladspaPath  = "${profilePath}/lib/ladspa";
in {
  systemd.user.sessionVariables = {
    LV2_PATH    = lv2Path;
    VST_PATH    = vstPath;
    LXVST_PATH  = vstPath;
    VST3_PATH   = vst3Path;
    LADSPA_PATH = ladspaPath;
  };

  home.packages = with pkgs; [
    bitwig-studio

    # native plugins
    distrho-ports
    calf
    lsp-plugins
    x42-plugins
    x42-gmsynth
    dragonfly-reverb
    fil-plugins

    # support for windows plugins
    yabridge
    yabridgectl
    wineWow64Packages.stable
  ];

  # setup yabridge
  home.file = {
    ".config/yabridgectl/config.toml".text = ''
      plugin_dirs = ['/home/elaine/.win-vst']
      vst2_location = 'centralized'
      no_verify = false
      blacklist = []
    '';
  };
}
