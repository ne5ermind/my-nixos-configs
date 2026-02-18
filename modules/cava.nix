{ ... }:
{
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 120;
      input.method = "pipewire";
      color = {
        gradient = 1;
        gradient_count = 2;
        gradient_color_1 = "'#4E5754'";
        gradient_color_2 = "'#ffffff'";
      };
      smoothing.monstercat = 1;
    };
  };
}
