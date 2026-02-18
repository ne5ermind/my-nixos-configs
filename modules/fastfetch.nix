{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ./images/fastfetch-logo.png;
        type = "kitty";
        width = 18;
        height = 8;
        padding = {
          top = 2;
          left = 2;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        {
          type = "custom";
          format = " ";
        }
        {
          type = "custom";
          format = "╭───────────╮";
        }
        {
          type = "title";
          key = "{#0}│ {#31} user    {#0}│";
          format = "{1}";
        }
        {
          type = "title";
          key = "{#0}│ {#32}󰇅 hname   {#0}│";
          format = "{2}";
        }
        {
          type = "uptime";
          key = "{#0}│ {#33}󰅐 uptime  {#0}│";
        }
        {
          type = "os";
          key = "{#0}│ {#34} distro  {#0}│";
        }
        {
          type = "kernel";
          key = "{#0}│ {#35} kernel  {#0}│";
        }
        {
          type = "wm";
          key = "{#0}│ {#36} wm      {#0}│";
        }
        {
          type = "terminal";
          key = "{#0}│ {#31} term    {#0}│";
        }
        {
          type = "shell";
          key = "{#0}│ {#32} shell   {#0}│";
        }
        {
          type = "custom";
          format = "├───────────┤";
        }
        {
          type = "colors";
          key = "{#0}│ {#39} colors  {#0}│";
          symbol = "circle";
        }
        {
          type = "custom";
          format = "╰───────────╯";
        }
      ];
    };
  };
}
