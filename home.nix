{ pkgs, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./modules/nixvim.nix
    ./modules/hyprland.nix
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
    };
  };

  programs = {
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
        "$schema" = "https://starship.rs/config-schema.json";

        add_newline = true;
        continuation_prompt = "[▸▹ ](dimmed white)";

        format = "($nix_shell$container$fill$git_metrics\n)$cmd_duration$hostname$localip$shlvl$shell$env_var$jobs$sudo$username$character";

        right_format = "$singularity$kubernetes$directory$vcsh$fossil_branch$git_branch$git_commit$git_state$git_status$hg_branch$pijul_channel$docker_context$package$c$cpp$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$fortran$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$vlang$vagrant$xmake$zig$buf$conda$pixi$meson$spack$memory_usage$aws$gcloud$openstack$azure$crystal$custom$status$os$battery$time";

        fill = {
          symbol = " ";
        };

        character = {
          format = "$symbol ";
          success_symbol = "[◎](bold italic bright-yellow)";
          error_symbol = "[○](italic purple)";
          vimcmd_symbol = "[■](italic dimmed green)";
          vimcmd_replace_one_symbol = "◌";
          vimcmd_replace_symbol = "□";
          vimcmd_visual_symbol = "▼";
        };

        env_var.VIMSHELL = {
          format = "[$env_value]($style)";
          style = "green italic";
        };

        sudo = {
          format = "[$symbol]($style)";
          style = "bold italic bright-purple";
          symbol = "⋈┈";
          disabled = false;
        };

        username = {
          style_user = "bright-yellow bold italic";
          style_root = "purple bold italic";
          format = "[⭘ $user]($style) ";
          disabled = false;
          show_always = false;
        };

        directory = {
          home_symbol = "⌂";
          truncation_length = 2;
          truncation_symbol = "□ ";
          read_only = " ◈";
          use_os_path_sep = true;
          style = "italic blue";
          format = "[$path]($style)[$read_only]($read_only_style)";
          repo_root_style = "bold blue";
          repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) [△](bold bright-blue)";
        };

        cmd_duration = {
          format = "[◄ $duration ](italic white)";
        };

        jobs = {
          format = "[$symbol$number]($style) ";
          style = "white";
          symbol = "[▶️](blue italic)";
        };

        localip = {
          ssh_only = true;
          format = " ◯[$localipv4](bold magenta)";
          disabled = false;
        };

        time = {
          disabled = false;
          format = "[ $time]($style)";
          time_format = "%R";
          utc_time_offset = "local";
          style = "italic dimmed white";
        };

        battery = {
          format = "[ $percentage $symbol]($style)";
          full_symbol = "█";
          charging_symbol = "[↑](italic bold green)";
          discharging_symbol = "↓";
          unknown_symbol = "░";
          empty_symbol = "▃";
          display = [
            {
              threshold = 20;
              style = "italic bold red";
            }
            {
              threshold = 60;
              style = "italic dimmed bright-purple";
            }
            {
              threshold = 70;
              style = "italic dimmed yellow";
            }
          ];
        };

        git_branch = {
          format = " [$branch(:$remote_branch)]($style)";
          symbol = "[△](bold italic bright-blue)";
          style = "italic bright-blue";
          truncation_symbol = "⋯";
          truncation_length = 11;
          ignore_branches = [
            "main"
            "master"
          ];
          only_attached = true;
        };

        git_metrics = {
          format = "([▴$added]($added_style))([▿$deleted]($deleted_style))";
          added_style = "italic dimmed green";
          deleted_style = "italic dimmed red";
          ignore_submodules = true;
          disabled = false;
        };

        git_status = {
          style = "bold italic bright-blue";
          format = "([⎪$ahead_behind$staged$modified$untracked$renamed$deleted$conflicted$stashed⎥]($style))";
          conflicted = "[◪◦](italic bright-magenta)";
          ahead = "[▴│[\${count}](bold white)│](italic green)";
          behind = "[▿│[\${count}](bold white)│](italic red)";
          diverged = "[◇ ▴┤[\${ahead_count}](regular white)│▿┤[\${behind_count}](regular white)│](italic bright-magenta)";
          untracked = "[◌◦](italic bright-yellow)";
          stashed = "[◃◈](italic white)";
          modified = "[●◦](italic yellow)";
          staged = "[▪️┤[$count](bold white)│](italic bright-cyan)";
          renamed = "[◎◦](italic bright-blue)";
          deleted = "[✕](italic red)";
        };

        deno = {
          format = " [deno](italic) [∫ $version](green bold)";
          version_format = "\${raw}";
        };

        lua = {
          format = " [lua](italic) [\${symbol}\${version}]($style)";
          version_format = "\${raw}";
          symbol = "⨀ ";
          style = "bold bright-yellow";
        };

        nodejs = {
          format = " [node](italic) [◫ ($version)](bold bright-green)";
          version_format = "\${raw}";
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
        update = "sudo nixos-rebuild switch --flake /etc/nixos#nevernix";
        cfg = "cd /etc/nixos";
        matrix = "neo --colormode=0 -a -f 120 -S 7 -D ";
        ff = "fastfetch";
        check = "ollama run qwen2.5:3b";
      };
      loginExtra = ''
        if [ "$(tty)" = "/dev/tty1" ]; then
          exec Hyprland
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

        background            #131313
        foreground            #d6dae4
        cursor                #b9b9b9
        selection_background  #1f1f1f
        color0                #16181a
        color8                #3c4048
        color1                #ff6e5e
        color9                #ff6e5e
        color2                #5eff6c
        color10               #5eff6c
        color3                #f1ff5e
        color11               #f1ff5e
        color4                #5ea1ff
        color12               #5ea1ff
        color5                #bd5eff
        color13               #bd5eff
        color6                #5ef1ff
        color14               #5ef1ff
        color7                #ffffff
        color15               #ffffff
        selection_foreground #131313

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
