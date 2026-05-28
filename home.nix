{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.dms.homeModules.dank-material-shell
    ./modules/nixvim.nix
    ./modules/hyprland.nix
    ./modules/dms.nix
    ./modules/fastfetch.nix
    ./modules/cava.nix
    ./modules/starship.nix
    ./modules/zsh.nix
    ./modules/direnv.nix
    ./modules/spicetify.nix
    ./modules/kitty.nix
  ];

  home = {
    username = "never";
    homeDirectory = "/home/never";
    stateVersion = "25.11";

    packages = with pkgs; [
      telegram-desktop
      pkgs.bibata-cursors
      bat
      eza
      fd
      starship
      neo
      cava
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
      libreoffice-qt
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.th_TH
      dbeaver-bin
      # v2raya
      7
      zip
      geeqie
      pyprland
      lsof
      # google-chrome
      # chromedriver
      onlyoffice-desktopeditors
      (yazi.override {
        _7zz = _7zz-rar;
      })
      #(discord.override {
      #  withVencord = true;
      #})

      n2048
      bastet
      ninvaders
      nsnake
    ];

    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      BROWSER = "zen";
      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
      XDG_CACHE_HOME = "/home/never/.cache";
    };
  };

  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          useGrimAdapter = true;
          disabledGrimWarning = true;
        };
      };
    };

    udiskie = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    iconTheme = {
      name = "Reversal-black";
      package = pkgs.reversal-icon-theme;
    };
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/about" = "zen.desktop";
        "x-scheme-handler/unknown" = "zen.desktop";
      };
    };

    configFile."gtk-4.0/settings.ini".force = true;
    configFile."gtk-3.0/settings.ini".force = true;
    configFile."hypr/pyprland.toml".text = ''
      [pyprland]
      plugins = ["expose"]

      [expose]
      include_special = false
    '';
  };
}
