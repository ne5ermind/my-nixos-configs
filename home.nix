{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.mangowc.hmModules.mango
    inputs.dms.homeModules.dank-material-shell
    ./modules/nixvim.nix
    ./modules/mangowc.nix
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
      inputs.zen-browser.packages."${pkgs.system}".default
      wpsoffice-cn
      dbeaver-bin
      v2raya
      geeqie
      termius
      unzip
      (yazi.override {
        _7zz = _7zz-rar;
      })
      (pkgs.callPackage inputs.spotatui-src { })
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

  programs = {
    dank-material-shell.enable = true;

    fastfetch = {
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

    cava = {
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

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = ''
          [$directory]($style)
          $character'';

        right_format = "$git_branch$git_metrics$git_status$cmd_duration";

        directory = {
          style = "bold blue";
          #         truncation_length = 3;
          #         truncation_symbol = "…/";
          repo_root_style = "bold bright-blue";
          format = "[$path]($style)[$read_only]($read_only_style) ";
        };

        character = {
          success_symbol = "[❯](bold magenta)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };

        git_branch = {
          symbol = "△ ";
          style = "italic bright-blue";
          format = "[$symbol$branch]($style) ";
        };

        git_metrics = {
          disabled = false;
          added_style = "bold green";
          deleted_style = "bold red";
          format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        };

        git_status = {
          style = "bold red";
          format = "([⎪$all_status$ahead_behind⎥]($style) )";
          conflicted = "◪◦";
          ahead = "▴";
          behind = "▿";
          diverged = "◇";
          untracked = "◌◦";
          stashed = "◃◈";
          modified = "●◦";
          staged = "▪️";
          renamed = "◎◦";
          deleted = "✕";
        };

        cmd_duration = {
          min_time = 500;
          format = " [◄ $duration](italic white)";
        };

        add_newline = true;

        nix_shell = {
          symbol = "❄️ ";
          format = "via [$symbol$state]($style) ";
          style = "bold blue";
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      historySubstringSearch.enable = true;
      shellAliases = {
        ls = "eza --icons --group-directories-first";
        ll = "eza -lh --icons --grid";
        cat = "bat";
        btw = "echo 'i use nixos btw'";
        update = ''
          (
            cd /etc/nixos
            sudo systemctl stop zapret-discord-youtube.service
            sudo git add *
            sudo git commit -m "automatic commit on config update"
            sudo nixos-rebuild switch --flake .#nevernix
          )
        '';
        cfg = "cd /etc/nixos";
        matrix = "neo --colormode=0 -a -f 120 -S 7 -D ";
        ff = "fastfetch";
        check = "ollama run qwen2.5:3b";
      };
      loginExtra = ''
        if [ "$(tty)" = "/dev/tty1" ]; then
          exec mango
        fi
        eval "$(starship init zsh)"
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    spicetify = {
      enable = true;
      theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.lucid;
      enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
        adblock
        shuffle
        hidePodcasts
        fullAppDisplay
      ];
      enabledCustomApps = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.apps; [
        newReleases
        lyricsPlus
      ];
    };

    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      settings = {
        shell = "zsh";
        remember_window_size = "no";
        initial_window_width = 950;
        initial_window_height = 500;
        cursor_blink_interval = "0.5";
        cursor_stop_blinking_after = 1;
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        enable_audio_bell = "no";
        window_padding_width = 10;
        hide_window_decorations = "yes";
        background_opacity = "0.6";
        dynamic_background_opacity = "yes";
        confirm_os_window_close = 0;
        allow_remote_control = "yes";
      };
      extraConfig = ''
        tab_bar_edge            top
        tab_bar_style           powerline
        tab_powerline_style     slanted
        tab_bar_align           left
        tab_bar_min_tabs        2
        tab_bar_margin_width    0.0
        tab_bar_margin_height   2.5 1.5
        tab_bar_margin_color    #131313
        tab_bar_background      #131313
        active_tab_foreground   #000000
        active_tab_background   #d4d4d4
        active_tab_font_style   bold
        inactive_tab_foreground #c6c6c6
        inactive_tab_background #131313
        inactive_tab_font_style normal
        tab_activity_symbol     " ● "
        tab_numbers_style       1
        tab_title_template      "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title[:30]}{title[30:] and '…'} [{index}]"
        active_tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title[:30]}{title[30:] and '…'} [{index}]"

        foreground                      #d5d5d5
        background                      #121212
        selection_foreground            #121212
        selection_background            #b0b0b0


        #: Cursor colors

        cursor              #ff0088
        cursor_text_color   background


        #: URL underline color when hovering with mouse

        url_color           #b0b0b0

        #: kitty window border colors and terminal bell colors

        active_border_color     #ff0088
        inactive_border_color   #323232
        bell_border_color       #ff0088


        #: Tab bar colors

        active_tab_foreground   #d5d5d5
        active_tab_background   #121212
        inactive_tab_foreground #b4b4b4
        inactive_tab_background #323232


        #: The basic 16 colors

        #: black
        color0 #121212
        color8 #737373

        #: red
        color1 #ff0088
        color9 #FD319E

        #: green
        color2  #00ff77
        color10 #FD319E

        #: yellow
        color3  #ffffff
        color11 #FDFDFD

        #: blue
        color4  #b0b0b0
        color12 #BEBEBE

        #: magenta
        color5  #7a7a7a
        color13 #939393

        #: cyan
        color6  #787878
        color14 #919191

        #: white
        color7  #d5d5d5
        color15 #f5f5f5


        #: Colors for marks (marked text in the terminal)

        mark1_foreground #121212
        mark1_background #787878

        mark2_foreground #121212
        mark2_background #7a7a7a

        mark3_foreground #121212
        mark3_background #ffffff

        # START_AUTOGENERATED_TAB_STYLE
        # Feel free to update these colors manually and remove these comments.
        active_tab_foreground   #eeeeee
        active_tab_background   #1f1f1f
        inactive_tab_foreground #d6dae4
        inactive_tab_background #0f0f0f
        # END_AUTOGENERATED_TAB_STYLE
      '';
    };
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        useGrimAdapter = true;
        # Stops warnings for using Grim
        disabledGrimWarning = true;
      };
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
    };
  };
}
