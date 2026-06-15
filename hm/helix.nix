{ ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      editor = {
        # auto-save-after-delay.enable = true;
        cursorline = true;
      };
    };

    languages.language = [
      {
        name = "nix";
	      language-servers = [ "nixd" ];
      }
      {
        name = "python";
        rulers = [
          80
          100
        ];
      }
    ];
  };
}
